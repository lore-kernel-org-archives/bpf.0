Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B9357D19
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376172; cv=pass; b=aEOZPw1n4E4mRBFCUxo90ewd8+M/2IvAQTJeSRAEfMCZ6XcCndeVtA9zYU8yWnEAZwLHM3vsnmil3vh+iNLdh4qRNMEhiy+JnnML2eOK0PvG5zr4SCl9y7olPJc1WIIOYKHa3nBMVi3/cGBT7xJXxjaDDA4xSH0lpJleTgPBkrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376172; c=relaxed/simple;
	bh=n8olFxv2/B8lZ96dx6n2x6SHUcA86fdHDqLKScaviFM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=KMHn9UcUITg5QEQcsoenJ5E2XR5XGEuMKeoHByO0BAEpVODgwnEquT7v0JL5Vz6djR8q9j6x7fIjK1QySiTIKqFB40tWzWHX53DExIimys8xGeOQ2DdD4hG+QtTp2V6VP04EissqrypO1wBVtogBbbK26ZGB+RMQZDd8NyH6CTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqzPMldF; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqzPMldF"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c9a3acd40so13699081fa.3
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 08:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786376169; cv=none;
        d=google.com; s=arc-20260327;
        b=ssApL0jpEAexl4rb6Gi4ldPTPLuzo4nuX14xt+pDFWzLw/7lv1WOSc3aVUb96zkHpr
         FkvGO291zj1h7e9obfL8ETzOKnOJMXo4aqNOXMax1y9F8zoU4x7/VwupF+dpYSoPAJKI
         8/VKjniqgqFFeX79L+mGL6jFXYl2zMR+meKjsqMHlXlzODOB2cc2CCpVVm+05XFpfrUX
         TjoP6waz2xxw6l8tZa1NENYXU20aQEj6BrSSal1slfM39SW+uEf+W+u1rOnV1teV2sVL
         aitUm7leNC6/75Gca0/JF5XvtLI3JQp/QebUHO3JzhjpbR6pNEHP/0atFDyKna/B8YKf
         k43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YFVCchQzBB9Xntjm9ZDcdgmlYOmjw3/Zstjs0JA74WM=;
        fh=ja1Wlih1KilCshJWUJc/9+qi9bYTUBu5WWmC6XxNgY4=;
        b=YbVjy86cvkFBs7rzll0Fb2TdaS7aj/37oKOWOLi8x8qYu0aYJ0i/oRvVjT/T9HNng7
         GbzBzQwR5/UfgfyiuQw6+5pHrurBs3ciRWvjfX94RddUza6tWURmAVDWybXZw/7v0Jgj
         K8uU+Zgfwp0uNoKCJQZFMTljTIQn8a2y4fXlXui0ycYdu4eTN4bYeQm/iKVfDqYNEYIV
         O3jRQRl9Bdmjvn3jdIha6+1Ho3JixWWu0IHZDu/QkTUmwpQf82x3ZpsbueAianR2Ln4u
         00SZdgFPMunoP1isQSFbugMjg6X86qLaCslN31TisadjNvS95dAewFfDaL95XEuTep/w
         Ye2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786376169; x=1786980969; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YFVCchQzBB9Xntjm9ZDcdgmlYOmjw3/Zstjs0JA74WM=;
        b=IqzPMldFTXkjLCIn34KnAkZHuiXX+JARmXq6SujXBpGUMWHcLwY+X/gzsAkjUKxbeT
         7qv5ytrgVb1tQefxKYT/UkeiDBHaPKTjrB30i2NAyigtDTRAjW91SQV4KXiuE/5BemBt
         MGe7Z6O/wetrFZIiK59xfSm37R8T1Qp0EPu6GX+flnanCnLJUhFYcNLQbmLBak18zQip
         kKzKjadUogSxnn3gcLf0VolM877pStwPUmDiln050XnKm5zC4VB97Pbh0wB8CNXuWxxT
         07AYcxvXiUxeSphx/+QNQnm6x91oX1pCKUG2h4+qL8qQwH3yXqtt8y4i3Xh6/tVl4naq
         S+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786376169; x=1786980969;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YFVCchQzBB9Xntjm9ZDcdgmlYOmjw3/Zstjs0JA74WM=;
        b=c61ZCvAAiZ9iDD8L5wCQ9ZjOyLBMSZCcWQ8DDOK85FwXnlCJvU84CJ+JWxTTrbeBoC
         rZfAeAK8w2elcuF5QivhHxiW5ZTgMpHUr7JZ8q5slFZNTMQ9+mVpPuON79uxjhDP74i6
         yKtZBN0WFqHDU0k9I6CQfH4gQ2xxTlAoXOa6NdpzzSZp1LPZgY6Rd8GQ205NyBkKUhj4
         ITTdZpWrZTvY4DaoVA/EcqN1X94pLW9zGhc7cgGcG9F98psmc81vEPeNa4ZjMVA+nB8g
         MZKWrM+sfWI0uE+HzesxT9WVsqLzos64ryCpkhuxarunRPzAPNOwVKBzLzVaRMU4l8QU
         CdOQ==
X-Gm-Message-State: AOJu0YyqCrtqSKV3wHncWgPex3ZNEbN2jfMclDK/F8qHH+gFZuXryFXs
	4LbhxLGCkz3DUnV85/ddnFnwea5bmVzwKhnqAm8WUwrwYtyicsYZZzZExsW+obs66D6R948P/g8
	B3A6jcMpA4Mv9d4Fl25AOT/CaeOoLn7Jubd2EAT8=
X-Gm-Gg: AR+sD13TO1mWdC4tTMzdYguXp9etG2HIsJIv/dy2u1gXKLUl7v5Z3BxSlrYOQ5k9Apo
	ydsJEZiRHL5RT3UUeUdF9vKDm8p+91X2GbouHISWNf0q4CNBSYJZFzYEQoZ631+AAmVNtjpKGqN
	4gskKMV0NIJxpdhiKXdksu2wtg4OYmhOo+8XZeQwLHpmkVJoWQaYJc5VQB3E2KSWy+7lIjn2657
	svylBcjzMtykVjWAC3lU8Eva8d4usNuiS2bVXcm3g+LuiXsYNwebg4FoQSlmTMOSR100ybQg/N0
	9EZebcqgBLLQpYdy9+CTFGcNSnDDj6DfLC6b6tksojlwryuVe5ASohzN33J3zHvR9s2utNEkg4F
	VASSvcMsmhORRg7ix0WewUf2zUhZEaqPmSGEoJa1xXBllhrqEusdrnnKbLwcyH96M6F7Pvg==
X-Received: by 2002:a2e:be28:0:b0:39e:eb8c:351a with SMTP id
 38308e7fff4ca-39fbb22cd47mr48291721fa.27.1786376168628; Mon, 10 Aug 2026
 08:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Darren Carreras <carrerasdarren@gmail.com>
Date: Mon, 10 Aug 2026 11:35:57 -0400
X-Gm-Features: AUfX_mx21hSlWZJQWB17rjBHQJCz4dKq83gmqxnzz7aX-nPkDhDh0mpCrqF0ZKw
Message-ID: <CAOZ_KyvV-Ha7XDZHCUcyYKPMSUvMSrZ0NhmtMVy_KqWD0Ar4kg@mail.gmail.com>
Subject: [PATCH bpf-next] libbpf: avoid overflow in BTF.ext bounds check
To: bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, memxor@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 0ee0da46079d4e9453afe2b28acdaadc0f011042 Mon Sep 17 00:00:00 2001
From: Darren Carreras <carrerasdarren@gmail.com>
Date: Mon, 10 Aug 2026 11:20:13 -0400
Subject: [PATCH] libbpf: avoid overflow in BTF.ext bounds check

An invalid BTF.ext subsection length can wrap the pointer addition used by
btf_ext_parse_sec_info() on 32-bit builds. The wrapped pointer passes the
bounds check and parsing then reads beyond the copied BTF.ext data.

Validate the offset and length with subtraction before forming the section
pointer. Add a selftest using an overflowing func_info_len.

Fixes: cf579164e9ea ("libbpf: Support BTF.ext loading and output in
either endianness")
Closes: https://issues.oss-fuzz.com/issues/477315119
Signed-off-by: Darren Carreras <carrerasdarren@gmail.com>
---
tools/lib/bpf/btf.c | 13 +++++-----
.../selftests/bpf/prog_tests/test_btf_ext.c | 24 +++++++++++++++++++
2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8417de92d..744f33e2a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3364,7 +3364,7 @@ static int btf_ext_parse_sec_info(struct btf_ext *btf_ext,
{
const struct btf_ext_info_sec *sinfo;
struct btf_ext_info *ext_info;
- __u32 info_left, record_size;
+ __u32 data_left, info_left, record_size;
size_t sec_cnt = 0;
void *info;

@@ -3377,16 +3377,17 @@ static int btf_ext_parse_sec_info(struct
btf_ext *btf_ext,
return -EINVAL;
}

- /* The start of the info sec (including the __u32 record_size). */
- info = btf_ext->data + btf_ext->hdr->hdr_len + ext_sec->off;
- info_left = ext_sec->len;
-
- if (btf_ext->data + btf_ext->data_size < info + ext_sec->len) {
+ data_left = btf_ext->data_size - btf_ext->hdr->hdr_len;
+ if (ext_sec->off > data_left || ext_sec->len > data_left - ext_sec->off) {
pr_debug("%s section (off:%u len:%u) is beyond the end of the ELF
section .BTF.ext\n",
ext_sec->desc, ext_sec->off, ext_sec->len);
return -EINVAL;
}

+ /* The start of the info sec (including the __u32 record_size). */
+ info = btf_ext->data + btf_ext->hdr->hdr_len + ext_sec->off;
+ info_left = ext_sec->len;
+
/* At least a record size */
if (info_left < sizeof(__u32)) {
pr_debug(".BTF.ext %s record size not found\n", ext_sec->desc);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
b/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
index 7d1b478c9..77db87dab 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
@@ -1,9 +1,31 @@
// SPDX-License-Identifier: GPL-2.0
/* Copyright (c) 2025 Meta Platforms Inc. */
#include <test_progs.h>
+#include "bpf/libbpf_internal.h"
#include "test_btf_ext.skel.h"
#include "btf_helpers.h"

+static void subtest_invalid_info_len(void)
+{
+ struct {
+ struct btf_ext_header hdr;
+ __u32 record_size;
+ } raw = {
+ .hdr = {
+ .magic = BTF_MAGIC,
+ .version = BTF_VERSION,
+ .hdr_len = sizeof(raw.hdr),
+ .func_info_len = UINT32_MAX - 7,
+ },
+ .record_size = sizeof(struct bpf_func_info_min),
+ };
+ struct btf_ext *btf_ext;
+
+ btf_ext = btf_ext__new((void *)&raw, sizeof(raw));
+ if (!ASSERT_ERR_PTR(btf_ext, "invalid_info_len"))
+ btf_ext__free(btf_ext);
+}
+
static void subtest_line_func_info(void)
{
struct test_btf_ext *skel;
@@ -59,6 +81,8 @@ static void subtest_line_func_info(void)

void test_btf_ext(void)
{
+ if (test__start_subtest("invalid_info_len"))
+ subtest_invalid_info_len();
if (test__start_subtest("line_func_info"))
subtest_line_func_info();
}
-- 
2.50.1 (Apple Git-155)
