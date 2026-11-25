Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795601006;
	b=uzrZj4siFXrOhXTXq9V0+xkTr4YpNcc+4moz8a+fmp4JKHtzbueh/nc/+qBub/jgmA9w
	 sd/U1Nk+u95C43z0Kez1v8DWBkuZkoPDMSMqGvReUrOII9JnMIECOKEdqYFmEilgDEgXd
	 jpqsIkZTbbxdpDIASx98WybV5NFTCC9AZ/wLnMTmklbji/FDdG89cdd0znYq/uhMoTyx7
	 hVPSTWBHr5D5upisILmEvlRovGi+OJClp3/2nIfsrarccek1nSWAMHC+XPEBpP5o6kwGe
	 D5H8vTQ9anOdVv/UkmkLUnvQ1a6tGj00Unn+pYy4xj/l/hRi9OoTulnOppcCyU4xFBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4yqmOnJX29DOBy6vmcdiSt8m4vhrVknvos21mrTZvSw=;
	b=YEDHtELBFsbvNcGgTIEqXb0ZvZwWMFh9PBdCBp/V41aUCgauUxq1nkSOepRem25wm6mj
	 uspQ0EMkPpr4Da2wyBWPy5YkMOEiNntsXbQhfV1UKfpyQpgYWNvNlGQr24zf5OYOpoBhB
	 0ZKEMJnmtM1e8d6aRcRlg+HTglqwYjKgHntgPjRcSlg9dwFUpvGCVNtVf+aMkuQ4FJpdH
	 IJ7l/Tju+AiP2G0mLBrcNMC65pQCLpRrELyQxFz36q8fPPbiL8mN4e2/yjPsAgb02Q+IT
	 CkD1Pag/quiqNNlFutODh841/s9BS8vVwcXiFiOyEfc4JM2pLU10WADPCMZiY0psd8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ay9+Ssce;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.43
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F138606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F138606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ay9+Ssce
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5c0a520df2eso5559076e87.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 02:03:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795601004; cv=none;
        d=google.com; s=arc-20260327;
        b=ow0oCuLZa2EOHYpajN1bO9A3AXqmH0kM7nvtdDvhTTpLwh3dbF8oMDSI+9FOnV41GU
         B9IcR9nI6sEAu3CcHlX73m6K5TsYJ8KVtpKZKCr0hatrnl/y4/zXPHTT2RaWp56P+NNF
         x+hfBB3xlR+hq9Odd7lieaD3yDWGNu13yADcmTIQcXuqKNVE1F7A1PvXDNhMMCV7SEYr
         eRjnfPyYyCttpS+BpsB63ImlXGAOL8cSHUi2UabuD0LhLYtndb3Ar6BFgFmlhgSR00LO
         eg4eTHwuJPt9sy9XV9GJLRDfxKmocKkIWPDu04GFm2283+QHmFp0yH7+Ksbne2Jl8lu/
         LwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4yqmOnJX29DOBy6vmcdiSt8m4vhrVknvos21mrTZvSw=;
        fh=d19on6tNyYQfk7vmf/KSFupylEwKSkM1TVU2eX/HHSU=;
        b=I3VBGN0P9cAlJt4mOkSlvP2tp8eoTuhbmnlzCB9x5d6IrUndhrYg5DvpZZkuwhtVeG
         vBypry0TUU3diR7TTC7RyUjD4IXOEEpso4a83/TMaGJdhhs5HgBoCT0VdldMhzmrFRd5
         K5w6g79eS5k1sNyigI39+bzWwcclgVftc0885x77Lige9bkrVfFbqfmStOajZZcAlWcI
         8/iNEpZlzE4FoY1OjRlegLxWvYDzTAqMVzY+WtkUrd7Z4zwvy6Foqp5pzpHGc2wpQUMh
         C3cH5azGOImCd6iylJG7ZB9E/gMlX693QrH6borxroJ/Sx2Nz4h5cRUhqAjU4sUoA4si
         aSEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795601004; x=1796205804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4yqmOnJX29DOBy6vmcdiSt8m4vhrVknvos21mrTZvSw=;
        b=ay9+SsceQ9jHRcRMslrgmqdSOnvnudmMflbs1Avejl0zkOGZBGKpQA0dM6CYQutGwW
         9u/N0BGvFt06XERIVFzmv4f8jyisegG59kaO0/P/YagT9iWpfEJl3Wf045T5K5BD0Wqj
         cN+C1EROJW8WQY6Cp0ymeeN5pYoJaLNeCZX51EE0u5xJn7ueHxNNF+nAIR0PU/I5JwVU
         NOfZiH71ylqVnQzKUTYh137Au31crg7ZjGvYhf3PprVQE1EgZuXk2WwnUJdmY1e5WSYH
         EfQWhIwdnuBi26YrBLsUTA0hislhvKWy11bUZD1WXBQXYCxf5Nww4/Mu0LX3sbnOistz
         FpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795601004; x=1796205804;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4yqmOnJX29DOBy6vmcdiSt8m4vhrVknvos21mrTZvSw=;
        b=qgNhQNWexGLkonUNUAGv4NcLMLTrcCs6jWJ9B6hrtHBbKuzxeemKxQQsTdCZigSBkl
         5Z9mmf0jb/bP/ReiahOs3ZJGDHO+f2pbKzanyDICN1XWDSs5Oa6D4sFjEp7PD23L318Z
         g6mxOCj+BdjtQTHDLIey/6+axJy3yHPLs3sm0I7ahaM8uHdmMityjJEjFTKpI31mbMvc
         VcP+FkBdp4MOWcC8dYjGU5BW6o5MVeYpd0WmZbx0LmW32gz5Oc9JQ/k4M4PVHbKEO/5p
         4SJ30nJe/FXT/QtB4TDSQUYVikDwC7iX6WOtIUji3kAczx0J4qf1Jr1VsmN5P4F1BIG8
         wEbg==
X-Forwarded-Encrypted: i=1; AL+hErFKuVHicd5MvSjQZypiS6KlFGxV8jKATmzizgHypjGfQx5ECFS5OsZ4FPI9DWfYqxfeA6g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+g1rK7O7crrhWBddpOSI69t6a+4z4g21Cfygh4o+R0r/eT5CT2
	r6XQVY0xIzbOXNkLRisUsPQtb0vf3SpIyumDmz01C9EBPmR9or8D6nMONO88c75toqGV0Wy7KXu
	2ApyyrCeeA30n8cStER58BiA+0/x0muw=
X-Gm-Gg: AZFdTZcE4UefwGirRC2SMlY7+q6I8qdpk6hTWCn/NHjAmhU7OFl0DivOiPsHaRUbh3K
	ePDxd+rF6a+4SdQ8hFkSPRUteeMQT0UZ6QAKkHJ9y0x2ihHBaMfY2TBP50lOMA3eHFtdbhCbTFh
	FAuqnzoxEVOM1A8hFaOZd5MOgYPM735pQtzNHyg7Y2cMbopdxOnY6+ZD154eR8ovRCMA16+EjUf
	jm3C8TNTke4TWyE8ZYc9TKrmjnZuEpJHcRC1MpKUzECjUH9ZvRh1bGdzTUC3h0xE6vnN9ZEMsyl
	M58iocQA2IjZmQYzyGp7301ubtLA6lM12PEFWPeOkiHnOT5bfeZ7OfxkuC/mykUWIYijESq3CtS
	PP7UgzNF8cVKHMTnYKOTt7JgPHtzQ9wKfXw89Jw==
X-Received: by 2002:a05:6512:3e26:b0:5bf:dfb9:33db with SMTP id
 2adb3069b0e04-5c1bc894b28mr5679079e87.38.1795601004108; Wed, 25 Nov 2026
 02:03:24 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124230228.3868519-1-graypanda.inzag@gmail.com> <DN3TX43KWXO5.JWLJ9HO1C9K7@gmail.com>
In-Reply-To: <DN3TX43KWXO5.JWLJ9HO1C9K7@gmail.com>
From: Junyoung Jang <graypanda.inzag@gmail.com>
Date: Wed, 25 Nov 2026 19:03:12 +0900
X-Gm-Features: Aa3M54r5upvGV8Qfv_TsLuVCjrNe6583K5J-EQlsL_l6e_r1ayLjtruktTOLARY
Message-ID: <CAO7ntTSjpH337UucxpxSCTXud3yYi0MqfRELHFcER_enhu9fAg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: avoid NULL skb dereference in zerocopy receive
 with sockmap
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for the review and for pointing out the other paths affected
by a stale copied_seq.

I agree that this should be fixed on the sockmap side. I will look into
e5c6de5fa025 later today and prepare a v2. In the meantime, if the
sockmap maintainers have a preferred approach in mind, please let me
know.

On Wed, Nov 25, 2026 at 8:28=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 24, 2026 at 03:02 PM Junyoung Jang <graypanda.inzag@gmail.com=
> wrote:
> > Check tcp_recv_skb() before using its result in both paths. Also stop
> > before advancing beyond the last skb in sk_receive_queue. Neither
> > check consumes data in the sockmap ingress queue.
>
> This should be fixed on bpf side. Other readers trust copied_seq too:
>
>   reader                             with stale copied_seq
>   ---------------------------------  ----------------------------
>   tcp_recvmsg_locked()               WARN "TCP recvmsg seq # bug"
>   tcp_read_sock()                    frees new skbs
>   tcp_collapse()                     BUG_ON(offset < 0)
>   tls_strp_load_anchor_with_queue()  WARN_ON_ONCE(!first)
>
>
> pw-bot: cr
