Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770236;
	b=gXHNYsEQG/FoVMvdila9HVO1ttxzXJ39btzvnqj+NvLu/etFNBsr444mKqyBZIQI4zE/
	 4w1q1EMZgtQ1i75G4w+kfz3h7q361ur5rxaaz0RHc1pvUCEhGNwOK5Bh1mP/pmzX53sIX
	 0GZClEXSea/vjVL/guT9Q1UAKUfnsccLV/2y21mQR+J2SMDMlU9CwMD/ECi3xpkhfyQsv
	 l2imaFBHEs0hY4g1PuciDcsS9nY+V1ylZyngkdorfCCGgqUex+yIGjKQ/uX5CbZNu9E7a
	 H2yL4CoiyKBfRD247sR3ciOVXFiIEXwNyKygLavPjizGl3IW0StphRwXnU9a+jwcrBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wmrev9NkIy9R1ylq/ysJErXdhy8YhOPDELOqdlbYmtQ=;
	b=muRlUsUamJ7vAizx6rgYe1o8vsV7TAJYNMiy6qwyrNytWIyOeNjiK/csxk43wCQkbKJq
	 cvr4U30fjDlfJIX32Cd2QImlhEWkXc6SsYLOezGSHklAfcMGl1V4Na4Dlus2w19iBoT8/
	 9VShG4FKnyKrjJmAeN4ttPOHXOGCIR8EBchS2IcQb6QdLJz1D91TRsPNboTJHYrOtiycW
	 90g7eWpfBnfGRG7a7Hlpnhp2y+qbWnxsgiLvRJWNqDqhxlkAQnuhX8bq+fg3nltut213U
	 wAdj67Itqupv2vcZ+37zZPlG3lmXKeDKAWZ/VgYhnSv02bpdsOLk46VmfurAF6tApZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nbRKrW+v;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4510C606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 15:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4510C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nbRKrW+v
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-679a2b5fe87so1010318d50.3
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 08:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792770235; x=1793375035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wmrev9NkIy9R1ylq/ysJErXdhy8YhOPDELOqdlbYmtQ=;
        b=nbRKrW+vEd07S0Z92afqbHaYljzCeQuEYIfi8YU/RjH2Hqzsru8AgC/9NX/VqYHueA
         vrPsuk8HXf8OBxBAge4TXdiojPigx0HWOwuH+OKF+pGWv8HigwbqedH+rbddhKGWu3nK
         4ehIZnJaeLwU2mgs0heT1n7YgWDy1IFD2GyvT0tNqm8L9zmUsV8mi3xSfj9JUm7OLRXx
         jFsLeLPgcSicKW2WMHOwcPXa+Pn5sD2bm+in0snPMpYylLn7t+mVIV8cuWgtbop9/HnY
         sfEsMnQ9KE2Bmj3rJhPZaBBTykaypz+hG2FWA/dcOOuPojD6T5IuJlmIG6PNDC3KUW2P
         H7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792770235; x=1793375035;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wmrev9NkIy9R1ylq/ysJErXdhy8YhOPDELOqdlbYmtQ=;
        b=pOSDZvOygagPhDQJ7SvnpK7AbsVmdtHz+9X7XXxAmmmEgtwmD1YSHALUx5JtHv8Gq8
         H4dED32aQVb6GBuO6PEdsLsDiIFcjqyC90E2K71sIYonfAmL4BwgQELvWY4tKgEWGV4t
         CZ7wMs7n4LSvrx4iyW2dbXJPeLMU5krfQdGdIPoxvMNrEWS+OSMENiFDXOMll7SlusI/
         83VgqZ0bhPPWPcDZpCcNvWfyjk3biEuP/QPQvY30ogaakNPHNY0tt5e7O5llStPSN6RG
         mH0XRF8borw5PL8wAKzr+8zWo5VolHVXVvFNMaZMbQKT/jkTxbn64XrEhFkagM7w4WuK
         qhow==
X-Gm-Message-State: AFq9FYJxCK/pq/kN9/bXDrs/cGRwG0SCUy5RL9qFkB7sEGibpCdi+te6
	kC0RG8nb577SJECkFkAHrYRx+4qnJSeUps3Gzu8SA8VhTrpv9tVw8V44
X-Gm-Gg: AYBFou1nSgiJl0wZM8lbdWqEO753ptDKRIsH0QPirq5Q5sxU5Sf0gFfpr5YPV91gSdr
	S92g297dpSKRbx7+PSRYo/Hchs9gxl40zyt+2CHzxT3c6UH5kmMrnNfQ1Homl0riLC6VJmcgOY/
	Q1mleh5fxQNIAJdexyc6/XC/cruaEADrGX1Bg/9jPoADPfzlIOP1iVBONulvBMmw/BdNVoclb68
	T+1cJ1z3NO3qEhbXh6gMyZhfNLK/TGFTFygvgP3NNQlJlJOpaRYo+VzwpIupcbByJGArkOWq6l7
	pV6cUwge7hOO9OkBSB63Nx8wdh6w8Uw5o/sLstglS8E4rGusZ3emYWrVPh9A6Fcvc1AZ6On6DII
	uXQtBMUTBEJzee7ColDN3zyj/n4vsioym086l4ye7UoPRU7bE3baKb5d4kOQ7O/bYaX2WdBhZDH
	gmV2deoIKFzJJn6TQucNc8TcUrEMDU7LLUwCYhKwmCHH+h0SigkttXeCCixocn1k41irpEc2bxc
	yVXiOK0yy9MfATBf6V06zETX89PL3JXArrQ5sacwN4v3357V3sPEQT7WQ==
X-Received: by 2002:a05:690e:1406:b0:679:8f04:229f with SMTP id 956f58d0204a3-67a35c135a4mr1202609d50.161.1792770234983;
        Fri, 23 Oct 2026 08:43:54 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:acd0:a70d:cc94:a8fa])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a427f1861sm139502d50.3.2026.10.23.08.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:43:54 -0700 (PDT)
Date: Fri, 23 Oct 2026 11:43:54 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, ameryhung@gmail.com, 
	yonghong.song@linux.dev, puranjay@kernel.org
Subject: Re: [PATCH bpf-next v7 0/2] bpf: Track borrowed iterator result
 lifetimes
Message-ID: <att73Z9XpompG3k1@zenbox>
References: <20261021210754.3270023-1-xyx2021@mail.ustc.edu.cn>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021210754.3270023-1-xyx2021@mail.ustc.edu.cn>

On Thu, Oct 22, 2026 at 05:07:52AM +0800, Xu Yunxiang wrote:
> Make non-RCU, non-acquired struct iterator results borrow the current
> element lifetime by default. KF_ITER_RET_INDEPENDENT marks the explicit
> exception for results whose lifetime is independent of the iterator.
> 
> Trusted field loads and dynptr constructors propagate the source lifetime
> so derived pointers stay in the invalidation graph. Next preserves the
> iterator itself and invalidates old dependents before both return
> outcomes; destroy propagates outstanding-child errors.
> 
> As Alexei pointed out, the trusted-field rule is generic. Patch 1 now
> explains why an inode pointer loaded from an acquired file becomes
> invalid when that file reference is released, and how the same rule
> applies to fields derived from an iterator result. Patch 2 adds VFS
> tests for the valid before-release access and the rejected after-release
> access alongside the existing iterator lifetime tests.
> 
> The field-propagation overlap with Kumar's related work remains. This
> series introduces no general kfunc borrowed-return annotation; the
> separate bpf_real_data_inode() return-lifetime gap remains outside its
> scope. The iterator policy has no dependency on that annotation.
> 
> Changes in v7:
>   - Explain the generic trusted-field lifetime rule and the file/inode
>     example in patch 1's commit log, as requested by Alexei.
>   - Add a positive and negative VFS test for that example in patch 2.
>   - Rebase onto bpf-next b116ac6087541. The implementation's added and
>     removed lines are unchanged from posted v6; the field-load hunk's
>     context now includes the upstream __nullable handling.
> 
> v6:
> https://lore.kernel.org/r/20260927120406.1041915-1-xyx2021@mail.ustc.edu.cn
> Alexei's v6 review:
> https://lore.kernel.org/r/DMA2SZ5PRG4N.3I51MHSTWUUTS@gmail.com
> Kumar's related work:
> https://lore.kernel.org/r/DLGYPZAL708V.3GFLANAPH2L8O@gmail.com
>
It seems like my patcheset [1] is partially duplicitive of this work.
My fault. I think I got confused by patch 1 subject and only thought it
was an iterator fix.

Seeing as you are further along, I'll yield to you for the iterator
lifetime fixes and the trusted field lifetime fixes :) (everything in
this set)

I'll continue my series and focus on the __derives_ret suggested by
Kumar and the RCU trusted pointer fixes / "Don't apply the trusted
field lists to an RCU-protected parent" suggestion by Alexei instead.
Plus selftests.

Just sending this to deconflict.

Thanks,
Justin

[1] https://lore.kernel.org/bpf/20261020145059.2146170-1-utilityemal77@gmail.com/
> Validation on this candidate with a matching bpf_testmod:
>   - W=1 verifier, full kernel and modules builds passed.
>   - Changed BPF objects and required fixture compiled strictly.
>   - iters: 1/122 passed; 0 skipped.
>   - dynptr: 2/137 passed; 0 skipped.
>   - file_reader: 1/10 passed; 0 skipped.
>   - verifier_vfs_accept: 1/7 passed; 0 skipped.
>   - verifier_vfs_reject: 1/13 passed; 0 skipped.
>   - kmem_cache_iter: 1/3 passed; 0 skipped.
>   - dmabuf_iter: 1/4 passed; 0 skipped.
> 
> The new before-release VFS program loaded on both the unmodified
> baseline and this candidate. The after-release program loaded on the
> baseline and was rejected by this candidate with the expected scalar
> access diagnostic. These annotated programs are load-only.
> 
> The VMs used panic_on_warn and panic_on_oops. No WARN_ON report,
> Oops or panic was found. Unprivileged BPF was enabled only in the
> isolated guests.
> 
> The broad test_progs build used BPF_STRICT_BUILD=0; no compile skips
> were reported. The unfiltered full
> suite, sanitizer and architecture matrices were not run. The fresh
> baseline comparison covers the new VFS example.
> 
> Please queue the verifier fix for stable after it reaches the BPF tree.
> 
> Xu Yunxiang (2):
>   bpf: Track borrowed iterator results by default
>   selftests/bpf: Test borrowed iterator result lifetimes
> 
>  Documentation/bpf/bpf_iterators.rst           |  10 +
>  include/linux/btf.h                           |   1 +
>  kernel/bpf/btf.c                              |  13 +-
>  kernel/bpf/verifier.c                         | 103 ++++-
>  .../selftests/bpf/progs/iters_testmod.c       | 370 ++++++++++++++++++
>  .../selftests/bpf/progs/verifier_vfs_accept.c |  17 +
>  .../selftests/bpf/progs/verifier_vfs_reject.c |  19 +
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |  25 ++
>  .../selftests/bpf/test_kmods/bpf_testmod.h    |   4 +
>  .../bpf/test_kmods/bpf_testmod_kfunc.h        |   5 +
>  10 files changed, 548 insertions(+), 19 deletions(-)
> 
> 
> base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
> -- 
> 2.43.0
> 
