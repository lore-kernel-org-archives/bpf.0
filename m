Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC2284B4F
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 04:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992391; cv=pass; b=GNSmdfcAHEskLe83z3/1LfLSwrQ9OxscQOoRw+QqjHYRf3iR4gJAgtQ94TD+qNObCKhfWGbUY+oUdiaM08nzKKBWI3FQvQ970wKK/mvPmkMs3qUoVE2c4HOum+xApv9IkCIDdsXoqx14b8R4feZUVdB+UdJOUdwkMxBXtSsoce8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992391; c=relaxed/simple;
	bh=Fi+kdpe7WvRf2GCT4ogJgFzTTNqdSBrO/vpBiE1iMQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnueXKRnno//4EIHCguqM+hYfED2RlBqmCFcIRmebt+zmQ+lxT843j5lizMmerWZC4Lkks2Ls1t5PjazpiPlEzl1MV25+lcUVsZUULtLzM3aTbmtoRREB+11IWSCERwwCb5xThedcqDdNOiUQRN446WlFpdk8YO7J6rfGczRIoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbbIv/Vq; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbbIv/Vq"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so3929372f8f.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 20:06:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771992389; cv=none;
        d=google.com; s=arc-20240605;
        b=IdmWy+WcTe8BPzZBZ8wBIHAaCMebjFq8YiZ8fe/5DrpheiPCvELsOju4CvRI7GTIe4
         yoap/WKCVPgMuexfDXZQWRorTO+GomiMRPNWgyWR/N4ZNwyon/F0q9tcXGUEyx+rjNmQ
         NF6pdZX9sTGrkVmsl9gH4vCIcgftp6V2CGklHe7sZUgXpF5vRgArGwFFQiMrvyhAZ1+k
         CSnDW8SzONAGHf2GFqUs8c+6NGz7C9BHUXeUVtJ0TYTin29enupiwTrD07judnHiCM8l
         x1EtPgBoUUxsCA3XkJ777oAiBY1MNb+aB6UPUwCXfXishQWxewIrL/YBeESBq/Fr9d5r
         P4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xQinALVMm/K9RZV50Dt2k45sON7lOGGuBufpsBey/wM=;
        fh=xurScvdk4OgWadhz4DnmtkWyNRJajXHSWj2cwyOJflU=;
        b=SUVwiulBCxHm9okiujBip7Lye69j+q0jMo8vO9KUU89OKahrDm1m4SCzpJZWch7HmM
         Dmmalxb14j3qRBPiEmdUgPlgAixuKw4WPC3kvLAbbJ3XwZMs5RMPdymKuMS2RugCrHjb
         9OTwoyonAVP3fzEntEwMk9cLuepHRnp1YysbtqjBTdu2JUxpFN5dbQR/wsaxgeoNjSSI
         Ae1kNu6G2i2NNEFJixFs2n+IREGHIS0cdJ7v8oxU0y/KAyiMPrmcofmj4oDTiqQsnfLU
         y/UiHHnQTn6r+6l7ExNGrQtb+lIKeeM2zemGTnnVqfxZn+myCrX+SSnOUoL/lXD+P9+L
         zMKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771992389; x=1772597189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQinALVMm/K9RZV50Dt2k45sON7lOGGuBufpsBey/wM=;
        b=QbbIv/VqjpJROftbsaQAdwe9E2lBaJp4HIy886gNAZXx80agbJZcMpH4snDoXHV/gq
         0IFo8YyTkn6qFa7e9JwT+Fc/PcNW/g/eG5VBW72afElLBduKBR1+29Gh1xRYWZ+fwCNI
         pr3STx4mvI+cvJMiNPdbKACm/u1J/a+x7g+uEdVSHzfCKQB1FyH1YtwFsTfBQhDTnVQA
         Jj7o87PphSrS2+OH+62/woUItlPZ+Dduz0kbRg0VND1JXDhX6F2FFHqlgqHATvFZg85n
         qDiJClVCVdQy0IRf+F8W9vPLx1z/E8b3Nv/BYlzlVK7h0Uv7QH2enyff+f1PqFg1KUrs
         L/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771992389; x=1772597189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xQinALVMm/K9RZV50Dt2k45sON7lOGGuBufpsBey/wM=;
        b=B8BtBeoVJn6pBXfHQA8gTWeIl8GVenmjecdt6LjASH49LHaG6yjnvFSeKsSZ8COYg0
         +CYshEQlBPJejv147rpLtMP3hf54tp04oBSafWaMSGPpEZuuipVjZ7wWw/ZCKlvO2dYV
         pkP2lqDkrE6UCEXWhvj1INo5zBxd/XdlbWUOcexrdhVEzrmOl+wGBBALFfaTMjUp7Q4m
         yWj6uN6q61kMGzRbAZstz5PEHUGTIqBqxfEFalKJUrhtu7waYUhKlvvXcMxkKDCOlVNY
         PvY93UdxxweoD7ahxyrHKOtFQaZK5WicL0xSqFy+MyLvjsVVStSPzXpHVxvm/owKS4Ei
         iagw==
X-Gm-Message-State: AOJu0Yx8YsSRfZgFbTxGK53AHKIKH5jeror6QYhm0b9QDZC/llt9JP+R
	73BYQ8nh7rfnuNwWFhuOxsnh+/PgNE8Zwke/f2bevcOJWD8UKBKB+hTpnJfWJNzeYudIVxd+DAY
	CgYcumU80MoKMwn/VmTp4QGELf0PnO6c=
X-Gm-Gg: ATEYQzy+vczabLC5yrVxB4fyafs6TSn1jPca/HADIQ5YxSNtXUiAORgXlEkcQT/h4TM
	HtG4hO7zmBLEd/YZpkWc7uFUorh2aPIZb5gT0YGP7i6VqJhHDXqzXb/go4pDLBrP/N4s6sdnE2D
	mQfTKhgn5iMyQ2Y9QuzqWwSW/1WfpmFQ1J37bacuf1kbodv+ivZ3Cf3LnSwQsshGMWewh7kWYPE
	sRAVf+YPt1iQTqgFbtJpgOQ4yixwwnsz1Zi48kN1FzZ5h5QhOZ3tO/aZBbM0ThMp6Iwri4mcTTk
	BwrDvRGuxQyDQPFKe3sw0g+Sk3fJCRSNJm8QKv8HdMuG2jD0f3+XCk3XfIf2Yr9n1zZ3MV1GBxX
	LgtaCOGgINY3UX5PsnvuYR1JENQ==
X-Received: by 2002:a5d:45c9:0:b0:439:8487:73bf with SMTP id
 ffacd0b85a97d-439848774c9mr6713839f8f.41.1771992388923; Tue, 24 Feb 2026
 20:06:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218042924.42931-1-anandkrshawheritage@gmail.com>
In-Reply-To: <20260218042924.42931-1-anandkrshawheritage@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Feb 2026 20:06:18 -0800
X-Gm-Features: AaiRm50fiorsm6xJbG-jE7y7y4BDj47ek38nJoU30RvjtWbz87B8DzjZJxXZKKU
Message-ID: <CAADnVQ+Z4n8e9kkZ1Tg1F3cnBXv-2QZmt2hiifnBhDGeuiRxiw@mail.gmail.com>
Subject: Re: [PATCH v3] bpf: cpumap: add missing XDP_ABORTED handling in xdp
 prog runner
To: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 8:29=E2=80=AFPM Anand Kumar Shaw
<anandkrshawheritage@gmail.com> wrote:
>
> cpu_map_bpf_prog_run_xdp() handles XDP_PASS, XDP_REDIRECT, and
> XDP_DROP but is missing an XDP_ABORTED case. Without it, XDP_ABORTED
> falls into the default case which logs a misleading "invalid XDP
> action" warning instead of tracing the abort via trace_xdp_exception().
>
> Add the missing XDP_ABORTED case with trace_xdp_exception(), matching
> the handling already present in the skb path (cpu_map_bpf_prog_run_skb),
> devmap (dev_map_bpf_prog_run), and the generic XDP path (do_xdp_generic).
>
> Also pass xdpf->dev_rx instead of NULL to bpf_warn_invalid_xdp_action()
> in the default case, so the warning includes the actual device name.
> This aligns with the generic XDP path in net/core/dev.c which already
> passes the real device.
>
> Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
> ---
> Changes in v3:
> - Dropped unrelated queue_index changes that were accidentally
>   included in v2

Toke, Jesper,
please review.
