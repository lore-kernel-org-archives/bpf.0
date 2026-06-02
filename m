Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC336681B;
	Tue,  2 Jun 2026 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393455; cv=none; b=lPMX0B9zPgMh044+z3xz3nXUC3Laol3UjSvaobsZJ/Yg5Ph5Y0hbmdXMb2uwDGc8d1Amsg6YLXMgTxBL+/FBUnXQkKuMnQtd3/I7YG8P1WC8vO1AtilczSBUgwYQvJVv2jfF5WT6IWj1UgZFHkyHmcODjJ348LbSLEUGK7TResM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393455; c=relaxed/simple;
	bh=TXLjdQ1E+U9juu+O7hYC7kwGay0OBgCCNf30yxp9UJU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IiP/3JJcwOV7ZQtmuuQiyKCafMco/PDdMbzBcDXmWc5pNa/hc4mojSfpM/B/hnSgL846Nq2s3Qg5+hb1Lz3ij6OkGiumafV9vkcD20sskzAMah3wRZvQD5e8St7drFGMtBqsG7tUkUSC1ypZ8ZbS3eCZlDVsV5SPPnOtrOZM2Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibTqZhcV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibTqZhcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C931F00898;
	Tue,  2 Jun 2026 09:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780393453;
	bh=twB56QNrDe7K9J9WZXuYE9Ri/F2DpZmCXzSGeWSPR1w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ibTqZhcVuJp3izab7YEkzcywx3TrJN0bJ+eFzn4pRBzLHg/UgjX/gpSWa5q/rzfUY
	 /wKH8fekmXzjFsVNXFbwPNt2PiXla23g2yQAkzK2dzYyTDjbxqfWLcyQ6xSPslYJ/a
	 ZiJqnV+kCiyekrbgjGzUZ2/FZngySIkfDRavIcm7Xkvogsj6JnpiI92KOugCVfl1pn
	 zSBCJ+EV/oOwB2+/4Tw4B7E25soK8zlvxxAARYuocRD9llhcTBoQ+/SNe4vQGQSHi8
	 bKh4pcPHW6g3KqhTi9Joe1ytGT0CZQqjN2oh5+JAo3ao9TD1M1aU4/mNX6K5gmrjSY
	 lOCht5nNj8KVA==
Content-Type: multipart/mixed; boundary="===============2473392902796465341=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <066717c2867758a399c6ad91da97ea2fd43deff80ddd7c3a60d99b6e43914423@mail.kernel.org>
In-Reply-To: <20260602085827.2562222-3-chenyuan_fl@163.com>
References: <20260602085827.2562222-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add regression test for kfunc implicit arg injection
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,eddyz87@gmail.com,yonghong.song@linux.dev
Cc: andrii@kernel.org,ast@kernel.org,bot+bpf-ci@kernel.org,bpf@vger.kernel.org,chenyuan@kylinos.cn,chenyuan_fl@163.com,clm@meta.com,daniel@iogearbox.net,ihor.solodrai@linux.dev,jolsa@kernel.org,linux-kernel@vger.kernel.org,martin.lau@kernel.org,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 09:44:12 +0000 (UTC)

--===============2473392902796465341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> index 68842e3f936b..ed0084453d56 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
> @@ -103,3 +103,43 @@ SEC(".struct_ops.link")

[ ... ]

> +int test_err_inject;
> +
> +SEC("tp_btf/sys_enter")
> +int BPF_PROG(sys_enter_prog_test_aux_inject, struct pt_regs *regs, long id)
> +{

This was raised on v2 by Yonghong Song, and it looks like it may still be
open:

  Not sure whether this patch makes sense or not. The CI has pahole 1.31
  so the test will always succeed.

  https://lore.kernel.org/bpf/9cc9ce47-c45e-4878-ad3a-6e6967399ab9@linux.dev/

The underlying bug only manifests with pahole 1.30, where module BTF is
inconsistent with vmlinux.  Under CI's pahole 1.31 the injection always
works, so does this test pass whether or not the fix is present?

In v3 the only change was an added paragraph in the commit message
acknowledging the pahole 1.30 scenario cannot be reproduced under CI, and
no code change was made to gate the test on the bug.  Yonghong has not
replied to v3.

Is there a way to make the test meaningfully exercise the regression rather
than always succeeding under the CI toolchain?

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26810234837
--===============2473392902796465341==--
