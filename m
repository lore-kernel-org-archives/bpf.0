Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD5387346;
	Thu, 21 May 2026 04:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336492; cv=none; b=HNVXWe4upV7jbxvG1SNLNoGRlRGuQ2FDLcb52J68qTgS5B9ygYnu8vxrpnejaJK/V4Ehw4zj7qUYhu/6ZPy+XJ+20IWvbLQ0zYuSnIYwYLfAngRInjRu7IG3IuuXqpF6qEk5qduQcf5mEPsIqj6fLc6uFnGyj3qi91kA2BQpRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336492; c=relaxed/simple;
	bh=KNVr7Ddww8P/fH7CsG8AP7nP4RKQ9SDov96Z0a+9+sE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=naBq+F9OVAvssjBoeyOdHlmz7R03MrBSVmLEYpvEtjcQtS9kCjiHDFBowv1i72LwFXUAEVOprzaDcZHkRGuMVWwpNFi0hgaA6qACaSEs/xs1I5b9PTT4T+hZBwPMe7P5Vct86DPc/l7tlxrZcHQHi3V0VT/GcsQRMKUkgx+pecE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9MvDJU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9MvDJU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD251F00A3B;
	Thu, 21 May 2026 04:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779336490;
	bh=ktiurG8gQUe/1S+iaJmyQLqazmMNPWoUGE9zBz9WSms=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=D9MvDJU52KejRcI3PRFdfVSTUEXSI5r/ge/ncP+mlt+QNW8ed0HJZ1vunydCw8Rw8
	 /tKfsnanfK9+04hrU0ManJklonJsaDQC8j/zIMOY9dsye9hQJfnIVTeFAQEHXXjLsV
	 aMbuprIEGEYT0tnFnmJRHivd/+LSU2DSP/H2j0pI1tH0ZsJ/Due9qy+b2wTDad2P60
	 LmDCK6nD7Yd/5iu7MnRDFcMWvJXdZPV2McTPe54yWSi+j18JB+fa8OoTIzQSg8qxjA
	 CJVqPUANIk1Sp0Aq6DR4qGd2Dly9wFV/upWWuqrUujTWIKIElOP6VFC1ULnNALcXoV
	 ZDsgfyzCAKeJQ==
Content-Type: multipart/mixed; boundary="===============5004193502830455528=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d1fb9e986434b92188b3b37514336794c49a807c0378badceda45c3c14bb9739@mail.kernel.org>
In-Reply-To: <20260521032306.97118-5-kaitao.cheng@linux.dev>
References: <20260521032306.97118-5-kaitao.cheng@linux.dev>
Subject: Re: [PATCH bpf-next v11 4/8] bpf: Introduce the bpf_list_del kfunc.
From: bot+bpf-ci@kernel.org
To: kaitao.cheng@linux.dev,ast@kernel.org,corbet@lwn.net,martin.lau@linux.dev,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,skhan@linuxfoundation.org,memxor@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-doc@vger.kernel.org,vmalik@redhat.com,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 04:08:10 +0000 (UTC)

--===============5004193502830455528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 59855b434f0b..804c201c28f3 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f3cf8d85bea0..35eebb5e7769 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -11671,7 +11674,8 @@ static bool check_kfunc_is_graph_node_api(struct bpf_verifier_env *env,
>
>  	switch (node_field_type) {
>  	case BPF_LIST_NODE:
> -		ret = is_bpf_list_push_kfunc(kfunc_btf_id);
> +		ret = is_bpf_list_push_kfunc(kfunc_btf_id) ||
> +		      kfunc_btf_id == special_kfunc_list[KF_bpf_list_del];

This isn't a bug, but Eduard Zingerman suggested in v10 adding a
is_bpf_list_del_kfunc() helper for consistency with the existing code style
(similar to is_bpf_list_push_kfunc()). This would maintain the pattern used
throughout the codebase for checking kfunc types.

Reference: https://lore.kernel.org/bpf/ca14a6fd8a1f3ce1e64c70b6d9ea2baf8df913ae.camel@gmail.com/



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26204125015
--===============5004193502830455528==--
