Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA82349AF9;
	Wed,  4 Mar 2026 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609432; cv=none; b=VHzla7UcHn7V7+K6lKsQN6R7GbjqJWkSGwZG/nN57rz5zzPqB68wTXbsvggwpVOEzMffe1sx5+do1x9LTte3JjmKqj7M3f2jI0LvZA02t33+AHDLkNspXUQLdZZyVKYqI9+pNjth5ydP8Ktpjq1PCOrQsUOqiVWQp3FcaHv/oJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609432; c=relaxed/simple;
	bh=Pc3bM+91eg3kO1mp/zLT3ZUzr/G3MN1o+YDogTK/raI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=b91Wn7iNgPmaLvWCUP/xEBO1NapZ3WqDs99rJMCAfz5/ARCQe4juSgZyrV9XbyPZi9iVOEOuC8rsaLtYjcz2jGLhSH5SqmcQimkPtRtL1IXuLOoYo4PA60kawzDNqYnwGvyDnSxgPcdrA6SE3zMzo1JAIzbxR28RDgPSxM1iVlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyD1njvh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyD1njvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FC1C19423;
	Wed,  4 Mar 2026 07:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772609432;
	bh=Pc3bM+91eg3kO1mp/zLT3ZUzr/G3MN1o+YDogTK/raI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UyD1njvhPbB3X6q//I/hjRTTTdJpiwWszUCbOHkiHUWzUkeh2bBUWpVAiSJE2993B
	 tMZ+1mz8o72PbIVymn6OSNjBvQwx6seez+4RjJzo2UD8bU+VpB1mUsJwONktXcxmxd
	 TjZniFGFxajlD4tDVr9zq6I069RjF46W5zfBvjubULM/fc/sEnmyaHvVJ/x+gsOZwn
	 4x2nQtzFedY/9EN8A9iyzdhT7tLDUwXwQNKckIy+UEVjJvG80DpZPJjuBJFcI7c7H7
	 /8KuRSjkW+zrzIFlw4J1mcCIXlCstb0EmXrG015ieXNQOEl4BgJd0dCPAEfZ8OUWya
	 E1EljnUxrGpog==
Date: Tue, 03 Mar 2026 23:30:30 -0800
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
CC: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D=5Bnext=5D_bpf=3A_Avoid_thousands_of?=
 =?US-ASCII?Q?_-Wflex-array-members-not-at-end_warnings?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aaZr2A1UPJq33127@kspp>
References: <aaZr2A1UPJq33127@kspp>
Message-ID: <30A4F6F9-9E41-4767-9949-8F89927CA159@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 2, 2026 9:04:24 PM PST, "Gustavo A=2E R=2E Silva" <gustavoars@ker=
nel=2Eorg> wrote:
>-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>getting ready to enable it, globally=2E
>
>struct bpf_prog_array is a flexible structure, this is a structure that
>contains a flexible-array member (struct bpf_prog_array_item items[];)=2E
>
>We create the new struct bpf_prog_array_hdr type, and use it to replace
>the object type causing trouble in struct bpf_empty_prog_array, namely
>struct bpf_prog_array hdr;=20
>
>Also, once -fms-extensions is enabled, we can use transparent struct

Typo: "since" instead of "once"=2E

>members in struct bpf_prog_array=2E
>
>Notice that the newly created type does not contain the flex-array
>member `items`, which is the object causing the -Wfamnae warnings
>in struct bpf_empty_prog_array=2E
>
>With these changes, fix the following warnings:
>   =20
>7659 =2E/include/linux/bpf=2Eh:2369:31: warning: structure containing a f=
lexible array member is not at the end of another structure [-Wflex-array-m=
ember-not-at-end]
>
>Signed-off-by: Gustavo A=2E R=2E Silva <gustavoars@kernel=2Eorg>
>---
> include/linux/bpf-cgroup=2Eh | 2 +-
> include/linux/bpf=2Eh        | 8 ++++++--
> kernel/bpf/core=2Ec          | 6 +++---
> 3 files changed, 10 insertions(+), 6 deletions(-)
>
>diff --git a/include/linux/bpf-cgroup=2Eh b/include/linux/bpf-cgroup=2Eh
>index 2f535331f926=2E=2Ee7d266600ac7 100644
>--- a/include/linux/bpf-cgroup=2Eh
>+++ b/include/linux/bpf-cgroup=2Eh
>@@ -184,7 +184,7 @@ static inline bool cgroup_bpf_sock_enabled(struct soc=
k *sk,
> 	struct bpf_prog_array *array;
>=20
> 	array =3D rcu_access_pointer(cgrp->bpf=2Eeffective[type]);
>-	return array !=3D &bpf_empty_prog_array=2Ehdr;
>+	return (void *)array !=3D (void *)&bpf_empty_prog_array=2Ehdr;
> }
>=20
> /* Wrappers for __cgroup_bpf_run_filter_skb() guarded by cgroup_bpf_enab=
led=2E */
>diff --git a/include/linux/bpf=2Eh b/include/linux/bpf=2Eh
>index 05b34a6355b0=2E=2E488de065466e 100644
>--- a/include/linux/bpf=2Eh
>+++ b/include/linux/bpf=2Eh
>@@ -2360,13 +2360,17 @@ struct bpf_prog_array_item {
> 	};
> };
>=20
>-struct bpf_prog_array {
>+struct bpf_prog_array_hdr {
> 	struct rcu_head rcu;
>+};
>+
>+struct bpf_prog_array {
>+	struct bpf_prog_array_hdr;
> 	struct bpf_prog_array_item items[];
> };
>=20
> struct bpf_empty_prog_array {
>-	struct bpf_prog_array hdr;
>+	struct bpf_prog_array_hdr hdr;
> 	struct bpf_prog *null_prog;
> };

AFAICT, this struct exists entirely to populate a single element of "items=
" in a global variable=2E (I only see "null_prog" used during the initializ=
er=2E) None of this is needed; globals will be correctly sized with an arra=
y initializer of a FAM=2E Totally untested:

struct bpf_prog_array bpf_empty_prog_array =3D {
    =2Eitems =3D { NULL, },
};

>=20
>diff --git a/kernel/bpf/core=2Ec b/kernel/bpf/core=2Ec
>index 229c74f3d6ae=2E=2Eac15ab8b7d3c 100644
>--- a/kernel/bpf/core=2Ec
>+++ b/kernel/bpf/core=2Ec
>@@ -2598,14 +2598,14 @@ struct bpf_prog_array *bpf_prog_array_alloc(u32 p=
rog_cnt, gfp_t flags)
> 	if (prog_cnt)
> 		p =3D kzalloc_flex(*p, items, prog_cnt + 1, flags);
> 	else
>-		p =3D &bpf_empty_prog_array=2Ehdr;
>+		p =3D (void *)&bpf_empty_prog_array=2Ehdr;

Then there also shouldn't be any need for the casting (or the "hdr" addres=
sing):

p =3D &bpf_empty_prog_array;

Etc

-Kees

>=20
> 	return p;
> }
>=20
> void bpf_prog_array_free(struct bpf_prog_array *progs)
> {
>-	if (!progs || progs =3D=3D &bpf_empty_prog_array=2Ehdr)
>+	if (!progs || (void *)progs =3D=3D (void *)&bpf_empty_prog_array=2Ehdr)
> 		return;
> 	kfree_rcu(progs, rcu);
> }
>@@ -2626,7 +2626,7 @@ static void __bpf_prog_array_free_sleepable_cb(stru=
ct rcu_head *rcu)
>=20
> void bpf_prog_array_free_sleepable(struct bpf_prog_array *progs)
> {
>-	if (!progs || progs =3D=3D &bpf_empty_prog_array=2Ehdr)
>+	if (!progs || (void *)progs =3D=3D (void *)&bpf_empty_prog_array=2Ehdr)
> 		return;
> 	call_rcu_tasks_trace(&progs->rcu, __bpf_prog_array_free_sleepable_cb);
> }

--=20
Kees Cook
