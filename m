Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827F3749FA
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033967; cv=none; b=ZCrEXdEd/+4xGcQ7bQlcfpu0g7c+bIqG4InTf/spnsh1w4zNBItSjB6QQzBZmF2R29kUOLHIo+7HuO5SJ4X2opSgP9E80nTU0nI6M1HwcEvvrxx8tT38Y/TYRyrd8As1Kbb2S2C6M3z/Qnh+L8ic+iglL3ToQTwq7D8atcd4ZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033967; c=relaxed/simple;
	bh=G00YHjqP3bT3ws7OX9mlgD6sNkuOI5ON+qLPcjzJ5rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSH4ApOevG6ZBfIOetkz+hwL1hCnc98Qg2wW3JGlPMq4gs2N6Ay3teEIIGDza8iefjqu451disN37PZbkzvru4vsWpwbc7T/CB0LHyqBJxL4IIX12RZky5dKKW0H2UJ1bU0ngyhiQJS3gpUF78yaQZK3b6RknbO9KPxuyxQ+bfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=fXMzF7Hs; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="fXMzF7Hs"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-307631dbfedso12887270eec.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1781033964; x=1781638764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mP79Pj+AGA3xIgjnkm3qbd2XZJduzfsdCp0zY5QTkXo=;
        b=fXMzF7Hsklq5g5iDJQvb/f+YOtr7R5Q1Ux24mulhEhddXRwK2/UXyS+tD09DRgCrij
         CanzmhEX/OubFqwGk/gYwxPqSiH1ibeA79/wEPw9Y1thtLsurO9YXocaDiU/1esslKh8
         SKoAVwYEKaYw/W8ev/tRvpnlimp6aW9pQF8Br88GChuFz5kBp1taJ6iKEZqdsCGWMndU
         7DLVBsUMzc0zu0n7FmDsPMLStaTP8s6t1ZqZLwMpvukdVPrgWJg81uqW7AsC75x/iZcF
         N8CPVbNoXfb/PXGVBtZK63zb8PnN/2LiOrgbCmvGxeXGxFni3n+3oWAtAXIcR4XeU3vG
         zR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781033964; x=1781638764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mP79Pj+AGA3xIgjnkm3qbd2XZJduzfsdCp0zY5QTkXo=;
        b=gY81GinJ9PvsxIgDTuuGV6/QeKu0gcUxNqJ04tJv8G+XdQCiQDR9OTU3T0LcuOkMH8
         1R6L32GDvpqoJVrZp9cs+PUG22H0hzUptrInqcvTypoTHWSdF8JQH2jy7HyKY5kOWgc7
         fCeZBWDYZF/k1jRqN87BZwwkZT3T0O8CoJdqUGknaRG8+HxVMbTX2j2no1gsuP+CGyJR
         5EhxJpV4sgF1fthEKy3/V9Kw1PFkYH0Zzt07Zs7XsIzzsWNLQicRmBQTX4/ljYia2oRw
         GzCAZZZCH0sSnbnqAoTek0D+jseS9gr/gRnwNMCg1q2TCKciuXH1AAFy/ICdqlCZ+EfH
         QDJA==
X-Forwarded-Encrypted: i=1; AFNElJ+025tTk7YijDnZvCDl6xSTYdt3CkAa/TwbiwpaUcf+w90jTrPC54PowjNUntwjeyL7q1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxADQYmhrq9OqMEC5hKedgw1xsGnC7MXnkBB3ACB4GwI6xfBBzl
	9gMrdHz5BcW62t/7m5zLSygsASRUrBxKMcCvhdMVHrk1ZDnV5iU/3q8LPkDlZzLtMQ4=
X-Gm-Gg: Acq92OGteFwpbY2g+itgui36Ifx4Im6uH1wfwK0AalkljvkqgkCsq8RboFi6TYKOKb+
	yYtUYf384QeBwJOqrjz9qGO2sco87O5q7RJZhC7Rqb+OoIiQoCeT1jToOXR3CA4BK3b/HrzLZTX
	Y2UvgNnrCTGPYjZE0xN4ekMLdiB8DKzeIxLJCwvsXaQeTAPuxb/XSlCHAKumjqUDheL9CpqK9DM
	Hjtt5+U1ps5WmOxBflt2TeqLlojuetV+mwoPcHz62jONU61lo5b5z/ibcW7qTU//8dkyxqBEQw9
	eJ1xyvWGtrY4GfbjUZeFPRjK+L+4+VXCFhywVj41BMY97CbSTGntbeeZCEvx5liBQX2ZSUIPisE
	wDQFnOCAcRfAzJJJg0dfXpDVuKwvD+DTCYmX2Fnzxs4usaVsWmLXMGzfg5n+tUrWMmxK0xZhFZ6
	8qKSq2kmpr5pzlVdeUhLxYL51WWBx1kbyg6/HcXOy+pY1RhVUxByx/aU4fv0FdjurjgdE=
X-Received: by 2002:a05:7300:7493:b0:2e7:c701:aa85 with SMTP id 5a478bee46e88-307d62db622mr3709830eec.17.1781033963904;
        Tue, 09 Jun 2026 12:39:23 -0700 (PDT)
Received: from localhost ([2601:647:6802:dbc0:cc9d:48e6:8d05:b444])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db56697sm23177016eec.2.2026.06.09.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 12:39:23 -0700 (PDT)
Date: Tue, 9 Jun 2026 12:39:22 -0700
From: Cong Wang <cwang@multikernel.io>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Zijian Zhang <zijianzhang@bytedance.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix integer overflow in
 bpf_msg_pop_data() bounds check
Message-ID: <aihr6sPEZ4BDual6@pop-os.localdomain>
References: <20260609183927.4021802-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609183927.4021802-1-rhkrqnwk98@gmail.com>

On Tue, Jun 09, 2026 at 06:39:26PM +0000, Sechang Lim wrote:
> start and len are u32, so
> 
> 	u64 last = start + len;
> 
> evaluates start + len in 32-bit and wraps before storing it in last.
> The bounds check
> 
> 	if (start >= offset + l || last > msg->sg.size)
> 		return -EINVAL;
> 
> can then be passed with an out-of-range start/len, after which the pop
> loop runs off the end of the scatterlist and sk_msg_shift_left() calls
> put_page() on the empty msg->sg.end slot:
> 
>   Oops: general protection fault, probably for non-canonical address
>   0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
>   KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>   RIP: 0010:sk_msg_shift_left net/core/filter.c:2957 [inline]
>   RIP: 0010:____bpf_msg_pop_data net/core/filter.c:3103 [inline]
>   RIP: 0010:bpf_msg_pop_data+0x753/0x1a10 net/core/filter.c:2984
>   Call Trace:
>    <TASK>
>    bpf_prog_4cc92c278f4d5d56+0x1b1/0x1e8
>    bpf_prog_run_pin_on_cpu+0x107/0x320 include/linux/filter.h:746
>    sk_psock_msg_verdict+0x357/0x7f0 net/core/skmsg.c:934
>    tcp_bpf_send_verdict net/ipv4/tcp_bpf.c:420 [inline]
>    tcp_bpf_sendmsg+0x766/0x1ae0 net/ipv4/tcp_bpf.c:583
>    __sock_sendmsg+0x153/0x1c0 net/socket.c:802
>    __sys_sendto+0x326/0x430 net/socket.c:2265
>    __x64_sys_sendto+0xe3/0x100 net/socket.c:2268
>    do_syscall_64+0x14c/0x480
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>

If you have a reproducer, please consider adding a selftest either
together this patch or as a follow-up.

Thanks,
Cong
