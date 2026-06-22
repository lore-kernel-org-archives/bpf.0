Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0006213959D;
	Mon, 22 Jun 2026 03:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782100126; cv=none; b=XZgnLPl+8j7nsex0THmyXgSqMhQbLxkreSeuGIG0Z97foi5prV3MwBXi3u56W5wW7oBVP1ozncchtIad5jp0/1pfit5eR1lZ8YcyE9Ri8cLf6HoqSM1hxASvu7ehQ3X5uZXMk0sA1bURH3JloEYVvkQrZC5fMEVDf2Lpq1OtlXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782100126; c=relaxed/simple;
	bh=3REHfgAHPGBwPHLaZIfD1OtT3EApNRpzWXC81/gTvKE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YJS4GZdtpnVXefNke4ZbLJYryHvf6NilCLi8se/5xg6+YnUSWQV9xyw3bHkAbmgaYwqaU7wfdzbRlv4kUhwhl4HuKXhnLg3uxvBihTHgqNe6xWex4e+G5RjGtOdp3NN23fEUGHTzn2QMJmFr8nvvjjt2QiAAyzGC85zQw1GVhBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmfdpzOu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmfdpzOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CDB1F000E9;
	Mon, 22 Jun 2026 03:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782100125;
	bh=b2QUG/WyDEXAj6V1faqdpCOVh2eudD5PdwIDWqyAa4c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FmfdpzOuAVL+GWNUcONjeKHAzpp+FNMdhOd8mbVBfrFsqGR1+pABmVpvlukOr+RXQ
	 RSWPFmKm6lnlRUssCXeFQGwx5f+XzMg8ZxnulY5cMH6mjS31IrGb4qlapHQ78wdWBI
	 xrO99miiSYHFJ6WxZ+XJXLuISwP1yHMIbXYjTiDbHzJke60IzxrvsfZhoEMOm2Q303
	 ksmYkAhz0EzygDUKepHkyeXgBYT8RmSvB/B9vfadQA26+mgUxk+0cqgSMGAZgPjefQ
	 L/Sx2USa+AtkuwYTL55pVKNiAPGd3uwvJuXYujIjZqaeS/uzeclCxB5sakgUoOE7h0
	 f1URnkx7/K9JA==
Content-Type: multipart/mixed; boundary="===============0598162036814715131=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <14978b536f33ec1e7b98b59b7b0809084bcbcd680442a2dd783ed80eaa8eb062@mail.kernel.org>
In-Reply-To: <70577DC64C69EA1B+20260622031255.1160657-3-chenyichong@uniontech.com>
References: <70577DC64C69EA1B+20260622031255.1160657-3-chenyichong@uniontech.com>
Subject: Re: [PATCH v2 2/2] tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands
From: bot+bpf-ci@kernel.org
To: chenyichong@uniontech.com,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,chenyichong@uniontech.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 22 Jun 2026 03:48:45 +0000 (UTC)

--===============0598162036814715131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     tools/bpf/bpftool: Reset vmlinux BTF after struct_ops commands
>
>     struct_ops frees the global btf_vmlinux object.
>
>     In batch mode, a later struct_ops command can reuse stale state.
>
>     Reset the BTF pointer and cached map info state.
>
>     Signed-off-by: Yichong Chen <chenyichong@uniontech.com>

This looks like a fix for a stale-state reuse problem in do_struct_ops(),
where btf__free() left btf_vmlinux and the cached map_info_type/
map_info_type_id dangling for a later struct_ops command in batch mode.

The cached state and the do_struct_ops() free path date back to when
struct_ops.c was first added.  Should this carry a Fixes: tag?

  Fixes: 65c93628999c ("bpftool: Add struct_ops support")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27927483612
--===============0598162036814715131==--
