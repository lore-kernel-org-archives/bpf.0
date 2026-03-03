Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B106B191484
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772533180; cv=pass; b=XEGLLyJLxQXpPTcgfopzjFvyYxjLyUG6XozaLgGpBMUEojMeJe3KPMu84VAuHoXGr1OGtVXbryblQgFzpTcx3EnbB7qiDHC/90CmQCunfoJlQl7b5iIWZluTaVGJlpK0HacobGEZF7vN8Tr0euC8XNJJOlgH+LsWgHPDTCXEMlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772533180; c=relaxed/simple;
	bh=L6xBecXDNKKJjA3BidIxnDUBNu+38hDbDTRiIBPmcm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIM+FQnJY7ABZGiHLwOZ1NtAeCj2HG6p+4Xr8TUSaSFkhOSWY115WpkobN8Who9mGiyBfD8AzNq73yb5iV43CXt6NnqwBY2ilZ2MGrbjPXNI6+Yj+d0ccsgGdkJBulUgv+FNAJ5ayFxtU6mAEQTsjoja6YWWEG7Kz4iyT5aN4I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uin2x54j; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uin2x54j"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-503347e8715so68612581cf.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 02:19:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772533179; cv=none;
        d=google.com; s=arc-20240605;
        b=a9nhso95fpkHF+HnKjwGRDtnvmZOf2P2//RLLG0hlmo3oWw5g3Q7V0d0U2RqRON5/z
         AkgU/6TPBwGXIPY09mUA9U7xk7zVYr3xTc5xwjIKVVUlfxNPSS7LJu39PkLudNJvZiSX
         hV2zzm+o+G1GKcnN0KV3nSun3Nu9t92gr+5gJuPY4ev7iNGoO+iD4tP574jQ21L2+XLI
         cKH8YrxsjRa+vVVr7CNL8mkrwcE95pu7/md0q9duK5lxyESCzrF62FsWut/1i2cUQf/e
         zFXfeaPhWm2hwI+t0j0MeY0EaM0FlNViK9JQ7RFahzs/dUv4p0eIvKHPMdBCmFzt6H5r
         +CgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5tpxZyfOhLlXWbzxEfVpHySW/amFUqYsZxjE+wKixMs=;
        fh=6grwZfeRO7MoIUC8c/XUofxH/4DZ2sCm8VtrsuCx5Uo=;
        b=Fv73tf0zMXRVblzUTFXy1Fl/EvEjShtzTmXN6uNZG+XRrRs2ETV0kjNiwf3L4t413a
         oiMUf6IElTdbYW22cg5rtynwCh9Xb22oZql5AejgyMa15nT6ZOAhhPQj19zWUdU8JVa+
         mr5jNhpd1rWSAnPe+PGSumHd1PxHLPQEmTOXF+4EtPreR1lAJiTniUSMXMs6F4Fq5m4O
         6UXqf2OdUhvUp4ZdgPNZh1jS72E+5Ev2KzthwR8zCVPCezlXtRI+v0z0s6iHer/nopo4
         uP5pWNLOajTf63999tTzVGeborAV1IaOywIoWi30smvk3Xg1zxJLQSlTIL/pm30d6xWP
         p4yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772533179; x=1773137979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tpxZyfOhLlXWbzxEfVpHySW/amFUqYsZxjE+wKixMs=;
        b=uin2x54jYGFW9ZhL+ilMAYRxjjaBnyUlMIx/+yM0PvOr3gfTWLKbDhXdRRMsFrK2Qf
         PHr6eh7tQ+JOvBn0DOxvIpzaxI418goKzFLeli8LGl4UlMbvW2YJfen0nH56tYeux1Va
         24FFNvVXb/Q70JDuCW7T/azpl8iOC3jy8LlAyKO5zu3a4l/RaACtpeahshQ98iHU+Qoe
         CsVtEJS2767mWugLxFZidmjaDXU+/HXWm2V6laz5fI14LjdB0ReuHe0SkH1fyxgJKcp/
         jujSCuP90zhn++1r3P4elyYnhiqPb7NirKdI1CFgLMStCBvK8Ju2sCZ2y+9x9zF6hvY+
         Vo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772533179; x=1773137979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5tpxZyfOhLlXWbzxEfVpHySW/amFUqYsZxjE+wKixMs=;
        b=T+/4pYudxK6oS/HMAckJ3vLn6g+42Ijxn3Nd3ABqjhmMg299CZn7OsmILlJuamjtHu
         V/qVYzr+zfqPOa2KedxtialXmpQO9A5egvmGR5T0DJ4rriR05g97dPorfoHOgp570mV/
         He0UnRR11t3W6EX6+CGDI6dlmuO+B09FTGQlRZMNj82l8rIOLRfmQCFxwoHRNzT5fa2h
         iuHPUPHywmR86mfGXQ+zfKCgcLGcb3AU04qXiSxVWv2T4yW4FrzBy+9DkyXZvBmO5Ki9
         3Mz29eEk+TD9kUlRN4aQp3qFp6cn4usGOBfNnB6u5HdOnxy4NJwZjflcosu6mJW3Y8f7
         325w==
X-Forwarded-Encrypted: i=1; AJvYcCVrTss6r0WZPU+x7eVsdkW37RciI5QY7cDlt+JAuUwr2vasbRdwiHNzC3mJSW3YoxsnY4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFOymTsq41Xf02GLhg7golQ/U5o4n1NcpbgXwid6m8Qw7Hr5rV
	SUef4kQumg9IOZXdC9EqxPeFrKx1koEz93uLa+uwC1MIlxs7NZt4zBPwmFkJreWe92R1Ib7jze8
	E3UaK6qNhLOBQ+u9sTK7zfoXFeh0LhGwOQctKeU+h
X-Gm-Gg: ATEYQzwCh1OEnAuwo/OgNfnv1whxj8lZ6Z3RxE+i0KghMSp+oxPpL2h8b10rE+7cr9Q
	fLeSuIbhUUBrL9FBIC8FuH40y01b9LrSFG1xPAhd9EOP6T9L/Kp5rKCn+qlZdPOpWJKEYt2GkVf
	oRgldGw7YqxeqfNXI77lve/gB6RCx93OkKQLNp633gaLJ0YkelwYhKqIT98NmWCvO/DCZqJfS0w
	Q3HPp7b6U+KCpXhM8TkAwqHuAOQbZ4GYaREy+5INtVWD/NxlzAPcAoBvfPvMgrFaTmixn3OkuNI
	V6WGPdg=
X-Received: by 2002:a05:622a:134e:b0:4d2:4df8:4cb5 with SMTP id
 d75a77b69052e-5075273ada3mr223945261cf.4.1772533178263; Tue, 03 Mar 2026
 02:19:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303100439.3172296-1-kmta1236@gmail.com>
In-Reply-To: <20260303100439.3172296-1-kmta1236@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Mar 2026 11:19:27 +0100
X-Gm-Features: AaiRm51B6TTY1LFq4MuKQeALL9CaUBBtA9iidPyKok_cWwkoYgWe7j8YAj-ijcE
Message-ID: <CANn89i+xwmBA-QiYwd_UR2_XK0aXZGZi8+uvBugQ2-MnmZvpaA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: shrink per-packet memset in __tcp_transmit_skb()
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 11:04=E2=80=AFAM Keita Morisaki <kmta1236@gmail.com>=
 wrote:
>
> Use struct_group() to group the three fields in tcp_out_options that are
> read unconditionally by tcp_options_write() and bpf_skops_write_hdr_opt()
> (mss, bpf_opt_len, num_sack_blocks), then replace the full-struct memset
> with a targeted memset of only that group.
>
> struct tcp_out_options is 40 bytes without MPTCP and 96 bytes with
> CONFIG_MPTCP=3Dy (typical distro config). Every remaining field is either
> assigned before first use by tcp_established_options()/tcp_syn_options(),
> or gated behind its OPTION_* flag in tcp_options_write(). This memset
> runs on every transmitted TCP packet, so shrinking it from 96 (or 40)
> bytes to 4 bytes reduces per-packet overhead on the hot path.
>
> Assembly comparison (x86-64, GCC 13, CONFIG_MPTCP=3Dy):
>
>   Before: rep stos zeroing 96 bytes (5 instructions, 12 8-byte stores)
>   After:  movl $0x0 zeroing 4 bytes (1 instruction, 1 store)
>
> Also add opts->options =3D 0 at the top of tcp_syn_options(), which
> already used |=3D without a prior clear. tcp_established_options() alread=
y
> clears opts->options at its top.

Please read Documentation/process/maintainer-netdev.rst (about the ~24
hours delay)

Also, please CC MPTCP maintainers, since this patch could impact MPTCP.
