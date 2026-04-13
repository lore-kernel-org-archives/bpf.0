Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B7346E6D
	for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095749; cv=none; b=HXseboiqyPC/stoqL0S7231BqhM6Qsj0J3Il6Ohv4WI57u4P4RZ/h1arS1wVafvi+UYX1lnu9LkmODcZt4iMdRKnszp2yzaUj/3GJCR21XOQ5ivcAQq02/Inas3HjNIGjP5s7lRkUePZeVYVNQqZOf19Ie/XikIxwQSWiC0udUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095749; c=relaxed/simple;
	bh=7sspJKDltG4HFJK2tD6VaW9zwgF0tLc1ZFdNtEqqBzM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rmkxge7tLZNcWmT3Yk3d46trXE6GjI80xKGhk3IeliDMeuerdnlrPCBtt+3Dd7bKpjOlHnNXKB7rkbLtoeGoWaEEm8hxWVEn5e7NYHwMEfEiFBk/e1bmbU7VclX81GuncNf/Tb7zW9NbIOpjdcs39qepxTF7e1paNz7QNd+3rSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5ogafts; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5ogafts"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-40423dbe98bso1763821fac.2
        for <bpf@vger.kernel.org>; Mon, 13 Apr 2026 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776095746; x=1776700546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GjKfqBprjxv4QTZk/hU0uWCqgeC5qXnesIkVQZLu/xU=;
        b=F5ogaftsMsDdYQULm4WUFIbtzuw/Xx2ZEvijpz7Fpb38mHnz4aIGbfcTy1jyjNvpCK
         LyRcB3TiHc4LcURAWte+dxdTmma3Ro6XQbgu58dvnMNTfNRPWRlQvbw/AUasJvQf/G+Q
         MqDcRzQXRRgL9Ukp91EkkS8ZqvWgxknXk5vxkQrrTVcy/53maOSiea7KCyp8koRaQX/T
         +ELeUnSL2haQLy97Dvs4SH7LPZeOGnaCQivDTBMIW6+p96d1eFVKNCX4qx39Gc6mBAgi
         mVC6uyX4eFvHvV5hTavn+MBti2itwTWaUbPWtVqpPDnqVNr9qhENXPPtlE+T64YlbUZM
         Orbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776095746; x=1776700546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjKfqBprjxv4QTZk/hU0uWCqgeC5qXnesIkVQZLu/xU=;
        b=sYkuor2pXv8TUpjUxPznkPRRcO4elN/Q28xD6nVF0f2cx7Rn1kPKkHEq508kFedcWa
         ToIDYUiZLy9ICUY6B1sz2MiVXBDgomPz3xP8PNksQKiyPL8X4k2o0xB0uwltcSAntnVE
         A5G8Q/NfsTpTaztbhLUTQ08tcnvnsHT+VPdKujHzh3uwCI4icH2fi//FZUrpKyeeEdZ4
         mLoEsGZcHwQMQKpOClKgdGU4FW8dLiDoWenkOuhSSC2tWLiP/yWChFTcOBbCUFZjSrXv
         Dt5a7E6578PtgGO0/NRrlZuE1MrIWxDqGRAW5dPTvqM4zSbLwIHA7TlPSgwODEXie3Y6
         A9KQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ycDjMap3GLFCKASW9z9QWnxFNfl1GPKX+8rWIH+UvhxN2BLobjrkMZms/Y8J3N8Ix1Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Obl6VLTh+QFK0TXiTiAclcUmIpG9i/HTufI7UBuNPtJGJdPV
	mMhUCKz8n00OMq+tJWGOgA4qARct2XNC/yGvi2WcXmkYt05Aq4HY7vA+
X-Gm-Gg: AeBDietFHrxImpSgw6gG1YVRGfSirGX+1U/c/UqFT+OezljyiZ5RjCK17k5ELPoIMcX
	2eZaKk1jaQdptcvCvYXJ+DWBKyEevPeRFCktuRz4UiOX/oUviDKbvdIWOYP2wcW1mzuURATwq7z
	ohNh2p7Z8Exw0w2oDFiInQ2bf9UAOXe1eHL4RH8l6qC8r0wc+MDkIyp9Q8tyaEdWXSSydXaLJk7
	mBm3O5mlTBTGFS0slKDcfPBVJETxdaF2CPz2U1al5//teucmLmaGqH3x9P+6y+tYjF+9jRcMoNX
	YIWVmg0+PdwSlgX+Za68JdVFNllRgvFhUl6CzJYW2eXHcveqzuA1XpBK2/PlNB/PpAcMZgc1OOw
	bIisNlPhOAR2M2dLc5jpzbsexIRYGgPXImwLfG2XIEvG5ksEAahyAoH91SyCHtUgkotDCheoqwQ
	B/Wt4vlM2XYJ/AKm1L
X-Received: by 2002:a05:6870:5b81:b0:416:3b62:2227 with SMTP id 586e51a60fabf-423e10a179fmr7211598fac.31.1776095746073;
        Mon, 13 Apr 2026 08:55:46 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb80ccesm8719752fac.13.2026.04.13.08.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:55:45 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <stfomichev@gmail.com>
Date: Mon, 13 Apr 2026 08:55:44 -0700
To: Quan Sun <2022090917019@std.uestc.edu.cn>
Cc: daniel@iogearbox.net, bpf@vger.kernel.org, dddddd@hust.edu.cn, 
	M202472210@hust.edu.cn, dzm91@hust.edu.cn, hust-os-kernel-patches@googlegroups.com, 
	ast@kernel.org, andrii@kernel.org, jiayuan.chen@linux.dev
Subject: Re: Infinite Recursion / Kernel Stack Overflow in
 bpf_skops_hdr_opt_len() via TCP_NODELAY setsockopt
Message-ID: <ad0Row2av871JSJL@devvm17672.vll0.facebook.com>
References: <d1d523c9-6901-4454-a183-94462b8f3e4e@std.uestc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1d523c9-6901-4454-a183-94462b8f3e4e@std.uestc.edu.cn>

On 04/13, Quan Sun wrote:
> Our fuzzing found a Stack Guard Page hit / Infinite Recursion vulnerability
> in the Linux TCP BPF Subsystem. The issue is triggered when a
> `BPF_PROG_TYPE_SOCK_OPS` program is attached and uses the `bpf_setsockopt()`
> helper inside the `BPF_SOCK_OPS_HDR_OPT_LEN_CB` callback to set
> `TCP_NODELAY` on the associated socket. This creates a logical loop that
> unconditionally pushes pending frames and re-invokes the same option-length
> BPF callback until the kernel stack overflows.
> 
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> 
> ## Root Cause
> 
> This vulnerability is caused by a semantic loop created by mixing BPF TCP
> hooks tightly bounded to transmission paths with auxiliary socket state
> mutations like TCP Nagle transitions.
> 
> 1. A user loads a `BPF_PROG_TYPE_SOCK_OPS` program and attaches it to a
> cgroup via `BPF_CGROUP_SOCK_OPS`.
> 2. The program intercepts `BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB` or
> `BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB` events and sets the
> `BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG` on the socket to enable custom TCP
> header options injection.
> 3. During the standard TCP frame transmission process (e.g., when sending
> data), the kernel needs to calculate the header's precise length. To
> retrieve the size of the injected option, `tcp_established_options()`
> invokes `bpf_skops_hdr_opt_len()`, which correctly triggers the
> `BPF_SOCK_OPS_HDR_OPT_LEN_CB` callback inside the BPF program.
> 4. Inside this callback, the malicious BPF program uses the
> `bpf_setsockopt()` helper function to force `TCP_NODELAY`.
> 5. Down in the kernel, setting `TCP_NODELAY` alters the connection context.
> Doing so invokes `__tcp_sock_set_nodelay()`, which unconditionally calls
> `tcp_push_pending_frames()` to immediately dispatch any packets that were
> previously waiting under the Nagle algorithm logic.
> 6. The recursive sub-call to `tcp_push_pending_frames()` initiates packet
> building again, causing a cascading invocation of
> `tcp_established_options()` -> `bpf_skops_hdr_opt_len()` ->
> `BPF_SOCK_OPS_HDR_OPT_LEN_CB` -> `bpf_setsockopt()` ->
> `tcp_push_pending_frames()`...
> 7. Without a depth limit or re-entrancy blocking condition on these socket
> callbacks, the repetitive nesting rapidly exhausts the kernel stack
> boundaries, pushing past the limits (hitting the `stack guard page`). The
> result is an immediate kernel panic leading to Denial of Service.
> 
> #### Execution Flow Visualization
> 
> ```text
> Vulnerability Execution Flow
> |
> |--- 1. `BPF_SOCK_OPS_HDR_OPT_LEN_CB` BPF Handler Executed
> |    |\
> |    | `-- `bpf_setsockopt(..., SOL_TCP, TCP_NODELAY, ...)`
> |    |
> |--- 2. `do_tcp_setsockopt()` called by BPF Helper
> |    |\
> |    | `-- `__tcp_sock_set_nodelay()`
> |    |     |
> |    |     `-- `tcp_push_pending_frames()` (Immediate TCP transmission)
> |    |
> |--- 3. Context switches to Frame Packaging
> |    |\
> |    | `-- `tcp_current_mss()`
> |    |     |
> |    |     `-- `tcp_established_options()`
> |    |
> |--- 4. TCP Header calls BPF back again for size computation
> |    |\
> |    | `-- `bpf_skops_hdr_opt_len()`
> |    |     |
> |    |     `-- Invokes BPF Callback: `BPF_SOCK_OPS_HDR_OPT_LEN_CB`
> |    |         |
> |    |         `-- (Reverts to Step 1 directly) Infinite recursion depth.
> <==== KERNEL PANIC
> ```
> 
> ## Reproduction Steps
> 
> 1. Load a `BPF_PROG_TYPE_SOCK_OPS` BPF program that:
>    - Checks the `op` field in the `bpf_sock_ops` context.
>    - If the `op` is `BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB` or
> `BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB`, calls the
> `bpf_sock_ops_cb_flags_set()` helper to enable the
> `BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG`.
>    - If the `op` is `BPF_SOCK_OPS_HDR_OPT_LEN_CB`, calls the
> `bpf_setsockopt()` helper to forcefully enable `TCP_NODELAY`.
> 2. Attach the loaded program to a chosen cgroup directory using
> `BPF_CGROUP_SOCK_OPS`.
> 3. Trigger a standard TCP connection (e.g., using `connect()`) within the
> targeted cgroup to establish the socket and trigger the initial established
> callbacks.
> 4. Force a packet transmission (e.g., using `send()`). This forces the
> kernel to compute the MSS and invoke the option length callback.
> 5. The forced `TCP_NODELAY` inside the callback will trap the kernel in an
> infinite recursive call sequence traversing `tcp_push_pending_frames()` and
> `bpf_skops_hdr_opt_len()` until the stack overflows, leading to a stack
> guard page crash.

The easiest fix is to probably return early from tcp_push_pending_frames
when has_current_bpf_ctx()?
