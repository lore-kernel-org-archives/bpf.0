Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93F18C008
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036499; cv=none; b=aIoPFcemxHkLxGcwqJYSI1rnnjtXAefLjUkpZoaJ7l0wipeF/Fs34Zwb4Os3WUvsaqScACIFDlXvRHbFxmA37L+fJFLVGKmNetiYoJmY1YpdsKiLol2/Hlk2P5bkYnblJNXIeMWWSZvdxCfz7rQFilB6zQiH31uVssO2zHCblhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036499; c=relaxed/simple;
	bh=YzW0BQ8vhXDvD2bpYSNX8BNHxNkJBtp2WOl/8Jr1LYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I3KfZmOZcWAefpfQQoJtxgghs62Nz+mWlyWJxett1VZNFhBUb0lRgHfFRtZF5sY5nOWKpXTAFsBxEGwkvu1jX/F7CJGyEWowHOkYU6D8pEfyJKJc2creOxERnndZdkqg7Q+3PyreLE+0MUUJim1NNvoWKVqi+113BEbFMyS6CBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5TcRjeE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5TcRjeE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248121F00893;
	Fri, 29 May 2026 06:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780036498;
	bh=YzW0BQ8vhXDvD2bpYSNX8BNHxNkJBtp2WOl/8Jr1LYQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j5TcRjeEoqrfjGMUv3SBFOP9U2rrMJ2y3cTQ/JdGMfFMHmw8t76JstBorQqoDKbCP
	 lDcUD8AMRpJMN5E/h+VkjwqSvgecsBhAA17O4IWzrH4Ir1psoQJmErUcG9yoKLb54a
	 9o0pKSRUOI4UCfx6Q9aTP+Oxt1rUBrtAELsuoIeqcFSZVxVlzBz05pvotwk6l86q0i
	 5uZmGxG3igq5LviPT2eUuHqPpnfbnbqZB+3ncC4cgYJaQ8j5SKjzPwvaXVJeHH7nXG
	 mOQboC4vPPDC7jn52iM/KRFstdHDdl38P9ZqYNzbZNOox0ffpp/KwiDEkycv/XV3G/
	 Sk8vtXNVXUYkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] bpf: cgroup: restore sysctl new-value
 replacement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dawei Feng" <dawei.feng@seu.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260529031026.2716641-4-dawei.feng@seu.edu.cn>
References: <20260529031026.2716641-4-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 06:34:57 +0000
Message-Id: <20260529063458.248121F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Inaccurate commit message and 'Fixes' tag attribution, which will =
cause regressions in stable backports.
--

commit 7f62fca2fcdc45d11be946984a6167b4460d8a59
Author: Dawei Feng <dawei.feng@seu.edu.cn>

bpf: cgroup: restore sysctl new-value replacement

This commit updates the return value check in __cgroup_bpf_run_filter_sysctl
to check for 0 instead of 1. It intends to fix an issue where the modified
sysctl value was ignored because the runner macro returns 0 on success.

> Commit 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value
> helpers") changed the success return value to 0, but failed to update the
> corresponding check in __cgroup_bpf_run_filter_sysctl().

[Severity: High]
Is this attribution accurate? Commit 4e63acdff864 introduced the sysctl hook
with the ret =3D=3D 1 check, which was correct at the time because the lega=
cy
BPF_PROG_RUN_ARRAY returned 1 on success.

It appears the return value was actually changed later by commit
f10d05966196 (bpf: Make BPF_PROG_RUN_ARRAY return -err instead of allow
boolean), which changed the macro to return 0 on success but missed
updating this condition.

> Fixes: 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value helpe=
rs")
> Cc: stable@vger.kernel.org

[Severity: High]
Since this patch targets 4e63acdff864 for stable backports, could this cause
a regression if applied to older LTS kernels (like 5.4, 5.10, or 5.15)?

On those older kernels where f10d05966196 is not present, the runner still
returns 1 on success. Applying this fix would change the condition to !ret,
which evaluates to false on success and actively breaks the sysctl override
functionality.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529031026.2716=
641-1-dawei.feng@seu.edu.cn?part=3D3
