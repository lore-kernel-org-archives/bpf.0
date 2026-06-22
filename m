Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FFA33ADAF;
	Mon, 22 Jun 2026 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782100129; cv=none; b=NDNqJiwSKel9/XgtYlPB1cDZC2HBh7/ZGQFJFkQCJFXsT56ec8MqMiLqCpaYWimCxERuyUr2Dsy0UYvZZBY/2kXMBcF/LrrUj5JIOFqokoQxSXw5N2go4XZ3B02vWOZiVLBSGXI5x8mOfAzpWzEEsGd9dhwUQXwO6KQEPbdU81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782100129; c=relaxed/simple;
	bh=vZogUn3WCGJXrQ+4ZWxeCkgSWByGy1demX0HfptoVGU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TuXPJ1/NKXB+RNHizY9o7vTbJqukqfSKB5IV9kR/O3PYU3a31VNfy2asTuJt0a4MWi7q92AOZkpjT89Hv7agx/PMtl/pMHjWANi8t65pt+yHcS2pz/Tleq6Zu9cv+1xlwEhDtVXERdhsKvH6yeCXV+nVpxVKamewWs03bX2pEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGHS7Y+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGHS7Y+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C344E1F00A3A;
	Mon, 22 Jun 2026 03:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782100127;
	bh=IM0a1oAZAtFn6d7harHKLW6ybMBdeq4zttfo5m4pub0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=LGHS7Y+r+mj5pIGtXYle0ET1qWFLTobqFKwX9atl8xkwbpyw1SyNRvf0uwxnGXzYS
	 xb/uT2tLl2fBO8qhUn8oDkYNYPatUZs+ZToksGYYq9cOqKZPyacs2GrY5u/ilnM+oI
	 ISSd5X6nvpojqBfnYvFj2oF9LhQ/iaGst/zOPJsQHpRMIpKqHkXEprLmmh6QqTXPi0
	 eXSHdhPdsFAdSS5/ay4dF6IgpvtfY0EbhjQW74jggJVVh705Iu5d/0CrhbSbNUQ4LB
	 /JpnzMwdFPJXuem+BVJZ/XSPMwm4pRY3eIjhd2QS+3NjgIVpLVgkm5SpQLnfnkMgqX
	 cFIYZzVfy3ouw==
Content-Type: multipart/mixed; boundary="===============0035552822720301172=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9336a9d3a4ce52b7efd537f80de958a72e5508074500a9d035f63bec9573151e@mail.kernel.org>
In-Reply-To: <70577B1B956C33F3+20260622031255.1160657-2-chenyichong@uniontech.com>
References: <70577B1B956C33F3+20260622031255.1160657-2-chenyichong@uniontech.com>
Subject: Re: [PATCH v2 1/2] tools/bpf/bpftool: Reset vmlinux BTF after map commands
From: bot+bpf-ci@kernel.org
To: chenyichong@uniontech.com,qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,chenyichong@uniontech.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 22 Jun 2026 03:48:46 +0000 (UTC)

--===============0035552822720301172==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> get_map_kv_btf() caches the vmlinux BTF object when a map uses
> btf_vmlinux_value_type_id. map dump released that object when the
> command completed, but left the global pointer stale.
>
> The same cached object can also be returned to print_key_value(), which
> freed it directly. That leaves btf_vmlinux dangling before the command
> cleanup path runs.
>
> Use free_map_kv_btf() for per-entry cleanup, and reset the cached
> btf_vmlinux pointer when the map command releases the object. This keeps
> batch mode from reusing a freed BTF object.
>
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>

This looks like a bug fix for the cached vmlinux BTF handling that was
introduced when map dumping started caching btf_vmlinux via
get_map_kv_btf()/free_map_kv_btf().  Should this carry a Fixes: tag?

  Fixes: 935d8fbd135d ("bpftool: Support dumping a map with btf_vmlinux_value_type_id")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27927483612
--===============0035552822720301172==--
