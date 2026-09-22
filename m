Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472CB28507D
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 00:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790038104; cv=pass; b=p+STv+NRpHquS+VWIui8RnjCtgr/5gdbCPRSlrz8h21vQ5nes+wmncqFoJA4vkc2T2vM1UWselZEq5OY9lQE/X5b5dYlxlgp4L834U59uvvVEEWdRezdCfteFASwu7cJtd5Lmzt3DYk+mm3hxivfGXqbAH+Kelr/5bqOT/tKXTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790038104; c=relaxed/simple;
	bh=BnrzXWHtRfdiJ3pqOPR5yk4FSFhY+j/DDmjhbz0Pj3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVh2swPHp6dWX3Rs6kjtSSyyXzoFlPRTe+1lWz9TSctX9vlFYXDHimcYzYuUPAl8oHUHWU5UPPsC3aGO6ZzX72obBVI/cHEDjEEZ4g4ZIPUBUee/tO6WSOYcHie3Q94nlOxIFZL2mxeEM7ztLK8KXRCkF/6/eM1BPq5tKHQUzVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J8ZSWqDN; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J8ZSWqDN"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb766bfd3so27483201cf.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 17:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790038102; cv=none;
        d=google.com; s=arc-20260327;
        b=JwRvkQ7ToY+r1lW82lbGEozFHGihNX2OWa9CBVgBkHQcJvMBsQnt+s5ew1IlPFzzcv
         tea7GQpOKytoLnWFvWYzj7cBNAP4kgtG9u7Je28rXglpaTcriT2lYPJ7I+SNTRL+sVCX
         k42BDMP72dm04lmBLNGKqbDrtbEuI3QTAdadUn6yR7Ym2CYyVOSguYOwAt2oQ1aPCxgi
         jStmlOzhNZCheKQiQm0LfMMxZ+0QwQFMVTJoYexwanOqUyD5cpVvTvMYnNarJmAWZ/mA
         c18oOLBuvOFf+oXu+bQf4eK1xIPptcGvO7EFy+x2XzlLmi4GSQPQJ7uYUZs4K2RNqmyc
         9A7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3LK+ozKSylFUUvnjcXsMMo9dDb+3ZVbSVsFuxLr9rAA=;
        fh=Ddr0vEdF+xXPiyDFKlFiwEobgjxfqrW01iG3dVJ4spY=;
        b=GwfF0oOnBJ1AdZOLC7gl4fURgI0tLPlU/b/cTo80FVjedLXAO+jJkncKfYMUnb3GC/
         TUiwWKJf97yKtvQLpnKR+1LlRsmgUCHjbEl1RNFQsvpth5xgp9Cppn5LQzYKT50f3+qN
         r6ptzZA8GtXqSfeC4hd5UCOwlxQ+cMFeMPeynWOV6qqjO5G98nktrJRNYycBeRqT0Wps
         0sLk4XvJdBxlVymOoI6NiW0NgNQ/o61zKyln8/eyKRGLkybR6odXP+p0qo2ZVLagxLR0
         rPOVfxth4kRyNoCDIiP8DOZV9yeQDamuvMTTZPKDI7fGrT0H+A4yogwigtsEfoTqwXPT
         tgMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790038102; x=1790642902; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3LK+ozKSylFUUvnjcXsMMo9dDb+3ZVbSVsFuxLr9rAA=;
        b=J8ZSWqDNsFwhCuzOtu3NhHQ36LmhGohqELCoJJe7RvR/BuzAmgGAXX9RYZnMZsWO8e
         H9lU1aJKE2W7c68WPoMjZq3msxqZoMxdZwvE/xsv6BBRj5pteb6D8Fmf3WWI295pQ7cb
         EA9VBQAnBcqCBjXnHDz1Mt+4e2MW//jkHRhxsdyV5o++ADfDzmq+V28mNv3lQfQjQ/t/
         zdqU/oGB3RT9oz/JXCkLJoTChZKzqlI27qRlrauomWhkurzIwEVO/jJ05bRN7eCBZcBg
         mvCJMcj/3jF1orwmRABQDiytjxiD7iL+DmLz38gn9VWgpyOxL7msw9e4MBUpJmj76K51
         6IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790038102; x=1790642902;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3LK+ozKSylFUUvnjcXsMMo9dDb+3ZVbSVsFuxLr9rAA=;
        b=WHRbXG+SvZE7d7VcbHrMGGNhYzyOL7aVz0DNBMaoaNziUBlkcYpuny1o5F00u0Hlgr
         aduueHtCpt7aJojkzIJgjtFhAd5GWd4k7o6FLu3MvJeW0ecdicnRw7pc5ZuRPS7pP3UD
         dGuoKPPZMbhRpE5xyggYkQw82h/BtWIyD0eFBSun+jZVT/K5QIc02bv2yicOfn5j9Vmk
         iz/Q1AQ1dz7isiHzJE78aQ+H5h36rnHRgMjl3oh27/FwOu6mqtAcEzGQrqU3ZpyAuz3I
         vQgMbBU787JycRIRPNYEYCexlAPo/RSrOpxhNbba9eaIy1ePDarVFMRStzL/Iudsl9XV
         RZmQ==
X-Forwarded-Encrypted: i=1; AKwUvBznu40xt2WuWRjDFU+3ZT7xawRiZxVuTib7zu6Fe/wff7I8u4giYJLy6KlEeSnpRG+zHFo=@vger.kernel.org
X-Gm-Message-State: AFuF++kZXal+cAAg2HHrohsk34uYfYJ/ABL1nBetcxgverKkP0JChNEK
	HbCLhIfiRjMK3kHE/ZVBCxE/CrGW9yPaDeDSyYj+NLkWiDlNpveNNCWLhnqa7ec8C4SFMsWoQUC
	CKcSjMb2Hh4ocly4AKegp1HE5SXqO0ZV18VB0VHZ+H+YtE+T+GJ/IsUelGXQ=
X-Gm-Gg: AYBFou2wVbAwxkpYH3sp47/Rxck6XuYf0bzfsle1kbtx3cJKMAF/Nf9XvEZi4S7+JPe
	8E1OGksjgsQ/lRIN1v/kBLMo+FLvdjGoYLIjmv2rPI7Nb7+LMzPIn1NcQId2eSJDxl0kR5NWGQs
	aJI+je/Tr4xLZM9fHK3bbRLhgmzP8Hbd6YW6p4V2T7Rny3Yow/Y+pxuwp3fp1J7Ho3rR25SBlbn
	jHSWWT6G+mU8+Sw8tqbSlNZaFzUMS5pYw8NjPHVioIwLnFP5vNgF+lU3eSjWQhD5ZCY5LDigs9+
	6/89fWN2lfTzoiMJ18jniKkcBnr6wOjJ2C8TP0tY7UcqoRdYfP3zcgNAvVJLrpWWkPvurHQR9RB
	CCI2dbgAAG6nKX0gAmoM2Sa5bVBF4s2SsrlLei9UtcD3gc50ztTLkNr5VIkfGOQ8D4CbB5D5nNG
	FVWifr
X-Received: by 2002:ac8:5cc7:0:b0:530:e8e6:bb67 with SMTP id
 d75a77b69052e-532d8e6e2acmr32479001cf.59.1790038101714; Mon, 21 Sep 2026
 17:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260916050144epcas5p3f7d6a44556baabd24027af8f4bce7893@epcas5p3.samsung.com>
 <20260916050255.1379192-1-irlanki.s@samsung.com> <20260921152604.2df7daaf@kernel.org>
In-Reply-To: <20260921152604.2df7daaf@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Sep 2026 02:48:10 +0200
X-Gm-Features: AcwNN1UYkBPuOvUGMNKq9NIUmTu6yNeNhs9fCtxsErhjcC2hyfYApg2nj1gadtI
Message-ID: <CANn89iJgAXaoepX1uvUbYhnutjvOPknPFheThf-gRWV-PbZZxw@mail.gmail.com>
Subject: Re: [PATCH net-next v4] tcp: add TCP_ECN and TCP_ECN_OPTION socket options
To: Jakub Kicinski <kuba@kernel.org>
Cc: Irlanki Sandeep <irlanki.s@samsung.com>, ncardwell@google.com, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net, 
	linux-kernel@vger.kernel.org, lorenzo@google.com, maze@google.com, 
	sporeba@google.com, motomuman@google.com, srihari.k@samsung.com, 
	g.pokhra@samsung.com, r.kumawat@samsung.com, raj.kumars@samsung.com, 
	ts413.lee@samsung.com, ramyashree.s@samsung.com, daeil2.hwang@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:26=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 16 Sep 2026 10:32:55 +0530 Irlanki Sandeep wrote:
> > Currently, ECN and Accurate ECN (AccECN) configurations in the Linux
> > kernel are controlled globally via the net.ipv4.tcp_ecn and
> > net.ipv4.tcp_ecn_option sysctl variables. This global approach lacks th=
e
> > granularity required for modern multi-application runtimes.
> >
> > In diverse network environments (such as mobile operating systems like
> > Android), different applications route their traffic over distinct
> > physical and virtual interfaces (cellular, Wi-Fi, VPNs, etc.). In the
> > wild, certain legacy network paths or misconfigured middleboxes (such a=
s
> > routers, DPIs, or firewalls) are known to blackhole packets with ECN
> > negotiation flags in the SYN, or silently drop packets containing AccEC=
N
> > option headers during active sessions.
>
> My gut reaction is that we shouldn't be adding a setsockopt here.
> This is a routing property, really, IIUC you're adding the setsockopt
> because you want to use BPF, in which case isn't it better to add
> a kfunc for this? Why go thru all the sockopt plumbing?
>
> TCP maintainers, WDYT?

Speaking for myself, I also cannot see why we need to support so much
flexibility.

BTW:

I have on my plate a complete walk through of recent fields additions
in tcp_sock,
mostly from the AccECN support.

ecn_mode and ecn_options have nothing to do in tcp_sock_write_tx group
in any case.
This patch  would hurt performance.
