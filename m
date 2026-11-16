Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794854274;
	b=sERFJb4vimEnrmnkbhr6zFG5BjysLGgXGuJkRIehihpPjXVvW9hCCihkjKXDGwHyzmgB
	 pXkqYx/4H3xo7pq5rs8bEYEjaTkWhoW6WJot+x275+dFYOTMPn8S+cappmEref5ykGTbX
	 rL9VXA7O4l96Z84/bphQ89BdosNuZnvYk58InWnsKMLTukEbZH4KKoHGi/ri+p0hY8t0m
	 FgETiOMubYpgeUCARlb05/nddo6W6DbyyqPincqJ9Fx2XMhXXYOeTPcnB0ou178r/S+1z
	 vwNFkAnRaqxYLDR0k06rW4/VRE4mX3rZRpQZL+Iao3y/L/6O1nRdYEOE0WTK0J0RuEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854274;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KR1B9yXoxe/iiaTpqvoEiLZa1nEPM31hRnKDTA2GAXA=;
	b=Iv7PAZzWIWVT3ahAwCwTwUU43Hu5y/N+GhUke+eESa50yP29CJ8pw8eQNdawyOm9rh+y
	 wpr/zqftNI8ov616KBBJLYRy5uqO6COGKW9MY75A1BIQ1X3LmlklPhI/zEd0+p7+CpBjk
	 gf8rq/00HTVDjb+vn83susUJCgX48xFruPERzVItqdtuzskdKhupMMnZh94l69OD6mxyk
	 8HTvhWvsFrdQyFmSR+S4sWzkhIEZaiCYVG/YPOxoBvjQR3E4UjKqhGshHS1xfK4advR3N
	 ycXlpsiVe9xi8Jqq+j4wlV6T9s06cmQt4UulOgJmUJyFlJFaAHhM4gtgs1GMeRjoq9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JcnW7rKg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1C606A330
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 18:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAC1C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JcnW7rKg
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb606491faso12680985e9.3
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 10:37:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794854272; cv=none;
        d=google.com; s=arc-20260327;
        b=mTZ0/Dti26mimfvAKWeQE3LAxUi/rbZr1BlwR4BJDzDK+NfEet2wFY3/D36ZHKiu6w
         QPTq0ZWZiuSkw0Ke1TwWeyaQ+Pw5KjPM+0wBlDfuQOBhAHKGpl+zybJmhfDmSaCEUgK3
         ABG0Qmkh022oLF8aDGo/Qy4Pl0gnQdzhU3jbkIbk5L2mSOP21cV/KdjZS54fJm/sMkiv
         +FKHvw5jL0booYpox5rwv24V47DhynfTUZ+LbbRn+wC8md39b/QuX85yAhEgib5Iau1a
         IMogUovGKFAx4v44JskjpJhJ7Qb4hGyR+cQBqcp5Cj8W6sA/guXLwQsPfQurT25PoSz9
         IC6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KR1B9yXoxe/iiaTpqvoEiLZa1nEPM31hRnKDTA2GAXA=;
        fh=uJxYm875QlU7D3XTIz/xrxFJ9bREF84qfTXVgyz2eO4=;
        b=BFcCce2S3klxiCc+uUQrMhW+jW1FlM/l3MHYzUGIjRLkP5skI80JfxHpYtzV/JPEru
         Dv4JEZ+9peMn3UTYvM/tVDIE/0azKoI16TDp97oTGGKj7igAl1hPW19SO1PhCdIRFEMe
         MOqMy7t4IOt+wJu2o7rHGBlzhuIdJuUTGPeyyVxIElU0qGhsfQgeE/h2yhAi9TyiUTpD
         RYe6Rq5TbKN3mJMEAPcTX2hW5Tj1N4N1pIw0gqeQ2cDtvn4SMXt91xT7mNYLrqzpZhYR
         Glk5ic6/4V4eZ37KPIh2U6vQ1HEdObSQZ4kcy7aV9dDb1CFU7XDMxS2VNCsC8WLS9GE8
         vrAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794854272; x=1795459072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KR1B9yXoxe/iiaTpqvoEiLZa1nEPM31hRnKDTA2GAXA=;
        b=JcnW7rKgXvUSyJ0m6cFXSUbtEFS+MeUbRgWICS1c0XoKk031VYU86s7LLC5UNUdRpq
         AQB0TagEIm5+ME+4yiw4gudTWOfnQ9tNoubCy9FsQA85vlmnHqTCDse/X55VQ6Vc24AF
         IHyFgHtwR1HT5Mr59+J2SZiCmP3Z9sFPI1RbtuzYGRCtE0HfJrtb7ehd/35MRmPZc5za
         mxVjnGm5CPUevLoUyPO1KVML5+tUWATUfik7/T1VpjDEs+sZtN3evtLKIIERYLcaUUWz
         z7vfy9uw0RQH4NEm3kVmIfhp0JlYmkhtHaHHLTp/8FIu6CdldnkO2GKQooxqlhmHWRHZ
         TolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854272; x=1795459072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KR1B9yXoxe/iiaTpqvoEiLZa1nEPM31hRnKDTA2GAXA=;
        b=hdwLovO4eIaK9iXJZ38dQfgVkNz076rV4R946rrLAPrliHwmbDV7Z6t1jHUYSwQPnL
         /gGW99ZbxzyHnz6QDHvGg4l1jAGiYz5ubN5yrX0ExhOA9lJO9KVeWbuulh8QcekFqVVM
         rT3ClVc3hqst50M5lWNZ04De+auFcXpBOjK8kUcU5kDwz1AM9n/WZefSXgeWc6wTh4+M
         7xmjf3jU3OD6NrE/t1XI53N4oJYHs6sgVR6zY+N5PoDLGKiTWwJiuMBwbBJoZjp3Wj8M
         vhRbXw3NUZVimV+RJ78xoqxjZNwy+Fr4Gb35vx7U37h5jJ4nj+fy6Bs/moQUHlsfuOcb
         X+Ow==
X-Forwarded-Encrypted: i=1; AL+hErHmXOBRPObOV8b1z2Q//aO3tru9QH0o5sS/pmWJdNlxgz/6ngFDKGVO/BnSaystvw1kEuI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZbSkmuZSzVF5fqKEoUH2JqZmIS61UXWwHZqnttJAqgL0ZXcHO
	+3sD+DtYQzf73pVm1DfIjbD/GgIBLTp4sMCrcPKqvRHz9nwqVlbsgiejEGGtAmTPFFQD+81/udm
	M1dS/1v5u/K2fYggkMwG5JYRpnh5WNmk=
X-Gm-Gg: AYBFou15rGwwHy4eAZMsxvefqxdDRXPufi6QXNI0C7tlbo6jUX4Pbwm0B6dxGtJb73q
	IA4typ6n8u3SKGuSIUkWTpXmeMnMjIpd93sH0t+FcB15WFDDrdQGzTQwRkYnAkSxVVcGPJBu7Pv
	GorcaFAxR04feJuySvaY/G5q7y1gZdrkGhRFf9SM9ctcgl3d291tN1g+uZtlBKK45f+p/XvvgHs
	rnQQO5JL+kYVChytaCTEi+AbCQJQ/GrbAfcGNoP8C3gfg2+oZxMOyzzOuklslKVLL8UTclsPqrc
	GxhdIIXzGrZG9zFQeTphD9tYCEavy4f9DnbZ3Gbi8luOS4pnSSr3EZ/UZJ8Fc3ZZejT9h9DLFql
	fuazWJB+iVtqoJcOIrOc9lAbQxtVfuF6j7G/a7I/flwA0lEwEMjto5iRZGxanx4KFpn0yLGa2tS
	LDkNgTU3Ghja7Sa4alxqA=
X-Received: by 2002:a05:600c:1c17:b0:4bb:6752:8400 with SMTP id
 5b1f17b1804b1-4bb6752853emr183093415e9.17.1794854272188; Mon, 16 Nov 2026
 10:37:52 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <30318.1794850523@30-11-166.wireless.csail.mit.edu>
In-Reply-To: <30318.1794850523@30-11-166.wireless.csail.mit.edu>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 10:37:40 -0800
X-Gm-Features: Aa3M54oflzVkGHmqRvikK5C4CgsXPYy3AjtiaSrLIBI6Ky3leAmWFtLbIBAZwaQ
Message-ID: <CAEf4Bzb03De+sraR6q+w8xTNHqp6vMQ5S52cYW2PWAR3jviuhw@mail.gmail.com>
Subject: Re: a riscv ebpf uprobe can wedge the machine by writing pt_regs.status
To: rtm@csail.mit.edu, Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:35=E2=80=AFAM <rtm@csail.mit.edu> wrote:
>
> On riscv, kprobe_prog_is_valid_access() allows a "uprobe" ebpf program
> to write ctx at offset 256, which is pt_regs.status. When returning to
> user space, ret_from_exception copies whatever value the ebpf program
> provided to the CPU's sstatus. One way this can cause trouble is if
> the ebpf program sets sstatus.SPP to 1, indicating that the trap
> should return to user space in supervisor mode rather than user mode.
>

We do allow BPF program to overwrite pt_regs and cause user space
program to jump to a different location (or even crash if we modify
registers incorrectly), assuming CAP_PERFMON + CAP_BPF. But yeah, we
shouldn't let it just wedge the host..

cc'ing Jiri, should we add some arch-specific range checks for uprobes
and limit it to general-purpose registers and IP?..

> An ebpf program can do this if it starts with
>
>   7a 01 00 01 00 01 00 00
>
> i.e. {code =3D 0x7a, dst_reg =3D 0x1, src_reg =3D 0x0, off =3D 0x100, imm=
 =3D 0x100}
>
> Robert Morris
> rtm@mit.edu
>
>
