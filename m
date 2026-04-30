Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D140DFDB;
	Thu, 30 Apr 2026 06:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777530481; cv=none; b=h+BBmruFIBjwnldGf5V/jDQ5Z8Ym0tDN4VHi7mphQ6Cq1WH+ouflI+yKHhU25/g1V6H/BllTKUDnVshDH5sylrd4wtOCOsoUBi0T0VnGn8YlvI5I6rXw7UPb/mLUlhwTkxkX+c/+CH7Vj0IiPcov9Ntm3yXNQeNtOCdZgrZ+OM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777530481; c=relaxed/simple;
	bh=r3OMNOCL0pgKuvSv3Ei0UmM/j6vWwbJ2y5g1lYGU+tc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=chIUWXopt4W2OT4XrDwqRFANhWOMphFoN7Ucb9WhmZlJYAg1SMXP4yf1eflf7ORDUpSOhpwEoPUGNyGgukxag79HFl2rHQakG1JNk4Szf7stYT9IqS60xWFS3TwIepIkdEMPwUohe63/X4/t45+0rX/ZMPXaAQiffnn/AvXL5RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAvDYLeq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAvDYLeq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2F0C2BCB8;
	Thu, 30 Apr 2026 06:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777530480;
	bh=r3OMNOCL0pgKuvSv3Ei0UmM/j6vWwbJ2y5g1lYGU+tc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ZAvDYLeqweHXaavYuEa/TMq/rCxg6eWYg/aBFTjdEbj1hgljHSL9D7vop78lGSp4s
	 E2L9AyDaMxtez6Y0taaZIRSGxRKczy73hpbVsfhnXc36lRhnP80VPRJhwZNWcl4ay2
	 btqTVTrcReuHYMmCr7COk0THkSOd4UBNCm5e2MC1pbzNsqdoVqvJx//1uKPVJWCltD
	 ZmKd2r2K6rbNReMzgRWHpAM3bfhg6ONQkSYH9dxVpCDZJLqKvSWktd32/e7jLh9cpt
	 IkjJ8Z07K5AzbFJKDTkCmItyShlp+kYhBQSTHTigtl812dXUUZhomiyz24sF09wIms
	 sdd3BxqV2V76Q==
Content-Type: multipart/mixed; boundary="===============8841790680717940984=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b34544363de19e30ab84c1f377b2255490b7b0e69572416efa21d0d2f9148452@mail.kernel.org>
In-Reply-To: <20260430054714.38980-1-chensong_2000@126.com>
References: <20260430054714.38980-1-chensong_2000@126.com>
Subject: Re: [PATCH 2/2] kernel/bpf/verifier: Support module kfunc resolution via instruction offset
From: bot+bpf-ci@kernel.org
To: chensong_2000@126.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,chensong_2000@126.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 30 Apr 2026 06:27:58 +0000 (UTC)

--===============8841790680717940984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 03f9e16c2abe..7e6a95e6821d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2734,7 +2734,10 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
>  	if (err)
>  		return err;
>
> -	addr = kallsyms_lookup_name(kfunc.name);
> +	if (offset)
> +		addr = module_kallsyms_lookup_name(kfunc.name);
> +	else
> +		addr = kallsyms_lookup_name(kfunc.name);
>  	if (!addr) {
>  		verbose(env, "cannot find address for kernel function %s\n", kfunc.name);
>  		return -EINVAL;

When offset is non-zero, module_kallsyms_lookup_name(kfunc.name) searches
all loaded modules and returns the first match. How does this handle the
case where multiple modules register kfuncs with the same name?

In the original discussion thread from January 2026, Alexei Starovoitov
asked: "but what about kfunc in module A with the same name as kfunc in
module B?" You acknowledged this concern and indicated it was in your plan
to address. However, the current implementation appears to rely on module
load order when multiple modules have identically-named kfuncs.

Reference: https://lore.kernel.org/all/CAADnVQLVQW-Mb_d+zT+aSpPOZ042erPVcSHVBx9PMGET+a754Q@mail.gmail.com/

Is there a mechanism to ensure the correct module's kfunc is selected when
names collide across different modules?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25150033548
--===============8841790680717940984==--
