Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5D043F091;
	Thu, 27 Aug 2026 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824092; cv=none; b=A+cJxGEanZg2+G3W9VK5+gU6RPT3B1qIP633NL2vnLziuHSCXK50RSaAaRNlzVsCQCXJOl3Y6fbbIOgict2KrxoDT7glLtZ4wHyIR3VyZsrIxi8127dT9hIKRfQpu9WfRHg3FFC4olqoWa9fH4ri1TUtkF05Z322VsaTCXMYDUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824092; c=relaxed/simple;
	bh=GtP7jyEp67HC1WMK/YlAt5/Rq7W2p2FaJz36PJdeE1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myZnnN4eDrN15jDVjZMUqlcLhqF6Vxmxu1l0ruiQi5Up6zRjShOStAU9YIroBU9KO96HGh/+56t71meZ5GuxGzCEuc6qy2bsMSn4gTAJWB99cUw0CmaOcMF3RDtnUNt0f3neuMzItqC7U6QxO4gW3IwvW5DUq2rp42rxF45/w9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: Xb7Q7cbmT5+X9oOzoV0etw==
X-CSE-MsgGUID: 5tkrww8oSe6ZswI0XkL33g==
X-IronPort-AV: E=Sophos;i="6.25,246,1779120000"; 
   d="scan'208";a="160664526"
From: meishaoming <meishaoming@xiaomi.com>
To: <ast@kernel.org>
CC: <andrii.nakryiko@gmail.com>, meishaoming <meishaoming@xiaomi.com>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <memxor@gmail.com>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
	<bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 bpf] bpf: array: use u32 iterator for max_entries in alloc/free paths
Date: Thu, 27 Aug 2026 17:47:49 +0800
Message-ID: <20260827094749.99196-1-meishaoming@xiaomi.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260820092246.61338-1-meishaoming@xiaomi.com>
References: <20260820092246.61338-1-meishaoming@xiaomi.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BJ-MBX05.mioffice.cn (10.237.8.125) To BJ-MBX03.mioffice.cn
 (10.237.8.123)

BPF_MAP_TYPE_PROG_ARRAY (and other array maps) take max_entries as a u32
from userspace via bpf(BPF_MAP_CREATE). Several array map alloc/free
paths iterate max_entries with a signed int loop variable:

    for (i =3D 0; i < array->map.max_entries; i++)

On arm64 (and any LP64 arch) int is 32-bit signed, while max_entries is
u32. With max_entries having bit 31 set (e.g. 0xFF00000A, observed from a
syzkaller run), the loop runs past i =3D 0x7FFFFFFF: i++ wraps to 0x8000000=
0,
which as a signed int is negative. The address computation for
&array->ptrs[i] sign-extends the 32-bit index (sxtw on arm64) into a
64-bit negative offset:

    array + sxtw(0x80000000) * 8 + offsetof(bpf_array, ptrs)
  =3D array + 0xFFFFFFFC00000000 + 0x108
  -> wraps to an unmapped address, level-1 translation fault, panic

This is reachable today because the existing overflow backstop in
array_map_alloc() lives inside the `if (!bypass_spec_v1)` block. Since
commit 2c78ee898d8f ("bpf: Implement CAP_BPF") renamed the old
`if (unpriv)` guard to `if (!bypass_spec_v1)`, the semantics inverted:
a root caller with CAP_PERFMON (or mitigations=3Doff) takes the bypass
path and skips the -E2BIG check entirely, so the raw attr->max_entries
is stored into map->max_entries unchanged.

Rather than rejecting max_entries > INT_MAX at creation time =E2=80=94 whic=
h
would artificially cut half the legitimate u32 range (a 3G-entry
single-byte map is a valid allocation when memory allows) =E2=80=94 change =
the
iterators to u32 i so the index zero-extends into the 64-bit address,
landing inside the allocated map region instead of wrapping negative.
This keeps the full u32 capacity usable and matches the type of
max_entries itself.

Changed all int i iterators over max_entries in arraymap.c to u32:
  - bpf_array_free_percpu      (pptrs[i])
  - bpf_array_alloc_percpu     (pptrs[i])
  - array_map_free_internal_structs
  - array_map_free             (pptrs[i & index_mask])
  - fd_array_map_free          (ptrs[i], the observed crash site)
  - bpf_fd_array_map_clear     (__fd_array_map_delete_elem)
  - perf_event_fd_array_release (ptrs[i])

Fixes: 2c78ee898d8f ("bpf: Implement CAP_BPF")
Signed-off-by: meishaoming <meishaoming@xiaomi.com>
---
Changes in v3:
  - Drop the max_entries > INT_MAX rejection added in v2 (per review,
    it would artificially limit legitimate allocatable capacity when
    memory is available).
  - Switch all int i iterators over max_entries in arraymap.c to u32 i
    so the index zero-extends instead of sign-extending; this keeps the
    full u32 range usable and fixes every alloc/free path at once.
---
 kernel/bpf/arraymap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 248b4818178c..21e08d7fc99e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -22,7 +22,7 @@

 static void bpf_array_free_percpu(struct bpf_array *array)
 {
-       int i;
+       u32 i;

        for (i =3D 0; i < array->map.max_entries; i++) {
                free_percpu(array->pptrs[i]);
@@ -33,7 +33,7 @@ static void bpf_array_free_percpu(struct bpf_array *array=
)
 static int bpf_array_alloc_percpu(struct bpf_array *array)
 {
        void __percpu *ptr;
-       int i;
+       u32 i;

        for (i =3D 0; i < array->map.max_entries; i++) {
                ptr =3D bpf_map_alloc_percpu(&array->map, array->elem_size,=
 8,
@@ -460,7 +460,7 @@ static void *array_map_vmalloc_addr(struct bpf_array *a=
rray)
 static void array_map_free_internal_structs(struct bpf_map *map)
 {
        struct bpf_array *array =3D container_of(map, struct bpf_array, map=
);
-       int i;
+       u32 i;

        /* We only free internal structs on uref dropping to zero */
        if (!bpf_map_has_internal_structs(map))
@@ -474,7 +474,7 @@ static void array_map_free_internal_structs(struct bpf_=
map *map)
 static void array_map_free(struct bpf_map *map)
 {
        struct bpf_array *array =3D container_of(map, struct bpf_array, map=
);
-       int i;
+       u32 i;

        if (!IS_ERR_OR_NULL(map->record)) {
                if (array->map.map_type =3D=3D BPF_MAP_TYPE_PERCPU_ARRAY) {
@@ -860,7 +860,7 @@ static int fd_array_map_alloc_check(union bpf_attr *att=
r)
 static void fd_array_map_free(struct bpf_map *map)
 {
        struct bpf_array *array =3D container_of(map, struct bpf_array, map=
);
-       int i;
+       u32 i;

        /* make sure it's empty */
        for (i =3D 0; i < array->map.max_entries; i++)
@@ -1011,7 +1011,7 @@ static u32 prog_fd_array_sys_lookup_elem(void *ptr)
 static void bpf_fd_array_map_clear(struct bpf_map *map, bool need_defer)
 {
        struct bpf_array *array =3D container_of(map, struct bpf_array, map=
);
-       int i;
+       u32 i;

        for (i =3D 0; i < array->map.max_entries; i++) {
                __fd_array_map_delete_elem(map, &i, need_defer);
@@ -1298,7 +1298,7 @@ static void perf_event_fd_array_release(struct bpf_ma=
p *map,
 {
        struct bpf_array *array =3D container_of(map, struct bpf_array, map=
);
        struct bpf_event_entry *ee;
-       int i;
+       u32 i;

        if (map->map_flags & BPF_F_PRESERVE_ELEMS)
                return;

base-commit: a13307e97d5c54b65720bb71fa379960ded1e51a
--
2.50.1 (Apple Git-155)

#/******=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=
=90=AB=E6=9C=89=E5=B0=8F=E7=B1=B3=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=
=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=81=
=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA=E7=
=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=81=E6=AD=
=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=BD=95=
=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=86=E4=
=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=E5=9C=
=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=88=96=E6=95=A3=
=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=E6=
=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=
=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=
=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=
=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=81 This =
e-mail and its attachments contain confidential information from XIAOMI, wh=
ich is intended only for the person or entity whose address is listed above=
. Any use of the information contained herein in any way (including, but no=
t limited to, total or partial disclosure, reproduction, or dissemination) =
by persons other than the intended recipient(s) is prohibited. If you recei=
ve this e-mail in error, please notify the sender by phone or email immedia=
tely and delete it!******/#
