Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EC73D3CE6
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484465; cv=none; b=D8KhDjIHa9wIAMnalpryPDh0TeGqloo3ie1IH7ETV6XRRDy4IPIoF9g87YHEkjw1jVhw8hnOuxQpoQ0pAtWdZCClK3M29Byiv44fESOewoRcqLVyE1SNvsXVe98sT/j6SZ9RyyvRLLs8UFX71N9PUdDQocINI3juaJN8BXDMGUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484465; c=relaxed/simple;
	bh=+Wwbpwk9WJacmVaW+gFHzZ2GVJuit8Jyi67VAUgtXGE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=owdtUsp0qhMOWDh/BI0G3uSoSUoyfoMFA89FuBF+wI+ycv5eLfOBfNsGw6Ne7X4zIEUQgvdUD7kVCyPVH268hhdGAOB0m32tRHn1ZDVm/XkJf3W5bhTRA0D/uFa0KcJgYpvosPQnjtKlgkNvbXLBb1KRhiIp6U9R/GOX8LMikeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1hw1dut; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1hw1dut"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74C31F000FF;
	Tue, 15 Sep 2026 15:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789484463;
	bh=qrHUnlGaDID5ryfq53BLpdQnzZ/cemG/vKJvBlqUctw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=O1hw1dut6ZKLkzH7WgQ1Ux3Pb5rljn07Epg5lYTSPfaVnWAhIkgwruW2NiJhUT3pj
	 Z8W0hiJX1FgpeDPbBePo1M8rgFX+tk8BqGQr9RMlJX9nTRIZDHbjP1vYaJJNPYfwHi
	 MdpkQKikQZFWEYgjnenBBH9i/ylKSOFcPGhhxcLVWLJNPAtcSsDwxamvaqYRekumsH
	 dDg+EkjX5+NxkSyVA5q3Dfkxj3K3MyGvXUCnkRpDfxyMby4Gck0JK0vlLuVboAzOE3
	 GJdtWTe1rR6OolmtX/kbePokHUTrml9+VbPIihKa5EcBvjSZFl8t6XTZIO6FmrNGMC
	 2/KKaqA6voqTw==
Content-Type: multipart/mixed; boundary="===============0131339769905086957=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <866af4cfac1e572fe03baeb2740c3854b909773a9a30838283dbf18d0d8ed79a@mail.kernel.org>
In-Reply-To: <20260915141004.1196460-3-memxor@gmail.com>
References: <20260915141004.1196460-3-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] selftests/bpf: Allow privileged preparation for capability tests
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 15 Sep 2026 15:01:02 +0000 (UTC)

--===============0131339769905086957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 28724de06322..940b6d8e47ba 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c

[ ... ]

> @@ -1049,7 +1059,7 @@ static bool can_execute_unpriv(struct test_loader *tester, struct test_spec *spe
>  {
>  	if (sysctl_unpriv_disabled < 0)
>  		sysctl_unpriv_disabled = get_unpriv_disabled() ? 1 : 0;
> -	if (sysctl_unpriv_disabled)
> +	if (sysctl_unpriv_disabled && !(spec->unpriv.caps & (1ULL << CAP_BPF)))
>  		return false;
>  	if ((spec->prog_flags & BPF_F_ANY_ALIGNMENT) && !EFFICIENT_UNALIGNED_ACCESS)
>  		return false;

Is the CAP_BPF escape hatch safe when the sysctl is actually on but
get_unpriv_disabled() returned true for a different reason?

Looking at tools/testing/selftests/bpf/unpriv_helpers.c:get_unpriv_disabled(),
that function returns true for three different conditions:

    if (disabled)
        return true;
    /*
     * Some unpriv tests rely on spectre mitigations being on.
     * If mitigations are off or status can't be determined
     * assume that unpriv tests are disabled.
     */
    mitigations_off = get_mitigations_off();
    if (mitigations_off < 0) { ...; return true; }
    return mitigations_off;

So it returns true when kernel.unprivileged_bpf_disabled=1, but also when the
kernel was booted with mitigations=off, when CONFIG_CPU_MITIGATIONS=n, or when
the config cannot be read.

The commit message justifies the change with "since that sysctl does not
prohibit their program loads", which is only accurate for the first condition.
For the mitigations arm, retaining CAP_BPF does not restore the verifier's
speculative-execution analysis, because bpf_bypass_spec_v1() and
bpf_bypass_spec_v4() in include/linux/bpf.h return true on
cpu_mitigations_off() regardless of capabilities - only CAP_PERFMON is
capability-gated there, and these cases deliberately drop that.

For example, tools/testing/selftests/bpf/progs/verifier_loops1.c:292 carries
__caps_unpriv(CAP_BPF) on maybe_exit_scc_bug1(), whose entire purpose is the
speculative path:

    /*
     * This test case triggered a bug in verifier.c:maybe_exit_scc().
     * Speculative execution path reaches stack access instruction,
     * ...
     */

Before this patch that @unpriv subtest was skipped on a mitigations=off host.
It now runs there, but with bypass_spec_v1 set the verifier never walks the
speculative branch, so the case silently stops exercising the regression it
was written for and reports a pass either way - which is exactly the situation
get_unpriv_disabled()'s mitigations check was added to avoid.

Should the two conditions be distinguished (e.g. have unpriv_helpers.c expose
the sysctl state separately from the mitigations state) rather than bypassing
the combined flag? Or at minimum, should the changelog mention that
mitigations-off hosts are also affected?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34981336633
--===============0131339769905086957==--
