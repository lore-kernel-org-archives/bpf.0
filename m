Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DE04A5AEB
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014651; cv=pass; b=LUOJwHosFvdZ0VXW9ePGLQo/9Eljw4zVjM6UItUPViEfbF6ifg3Kmyew1xLpSHrYeDCOQWRlUnOAJd6eHX9asAu1s4JFmCJvlpNHgTBNtIdUMlOE3GMjMibVmqXyyPrcarWx5M6nCYWTbeseYSzGyFMLtOIBm6o0gsuShvjsQW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014651; c=relaxed/simple;
	bh=u9ePfgEMWAzzAMBpjCw+oyPYM1jqTDkiGANBsXIAnes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZrBW6srmQ9DTcdA95aQPFAj/GPMys57BGdLPDrv4/2FFz4ns2TBQQ3H3V/OpaxaO/X/z23PIBR2UlnPZ2ru70vAn6n/p7x9rgpYhSfGA+3Ax5J22jXsC/NWkA3M9Zwu34FQm0RY+b5B1HNfYahIfh1UnfnxhTZVrXCzlybHgHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ge5B0Ojk; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ge5B0Ojk"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50299648ae9so547891cf.1
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 08:57:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769014648; cv=none;
        d=google.com; s=arc-20240605;
        b=cKEb6oWhM2GZaYvMt6dWffDMl/DZP/GyGA0XCnxWY6MYYux6FeT68D3T+vk+TBbA0m
         9w5cQ8b3Zpa5w6EyNlJaTli3ArHy88gsRm7El/iz4qkcmvwq+hhNSsiNmrkmhOZdGD3P
         jqJ3YfKenVJsfxWXXbcXeGwnCfjPwfSBG8E/wUpB23ZtNefwzJ9hr7EM9ul4Ph0z9b3D
         YK1OrkUseRCZwc+3WkN22X4rxLerMcw4uw7HWwdnjFiLriTO0wDl6qIboNPHsOwnttcH
         2h0xCDO4bkETzsc3cxn141KWNfFQZ1O9g995yqrRUNi1P1YMx70CpYFIiNY2kvz7XLQP
         2+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DzJlvh2XyLMGkwtl0QberzuQSLWoZAkg3qQo6w3w0Bo=;
        fh=MuYQxSJyUJ6cLQhcjtf2B2/GXmT7gKKwjH5B78dp568=;
        b=DsA7oB2pK8fUYaZvuA/PkHBDj9xZ2t5M1sylkj1CvRX4MaMJ+mQARqepbfuTu5sSGr
         PpdSkONif54i3dqyLih9/Ffzihg9mAFf2mdOXKyvyfYs+VxBT2VgdQyflS79phhwDoqt
         YGIwwMUo+Wv9ZWnPagdE1XFrSemRwjp7DXePG0xMsQWZv750Xq14i+0vrMNfvb7TaFvK
         DINmk527hZJ65EfQSPgIaaMSu/Hq4sH3cf7CYogBC1WtFt9U6/WTCwJlS2Qr0NpVpzEZ
         VYbOZ2fW5yfkDhdAGS8qimEQr0twVMP5Z+w9cWVYOz2QDfCJF6CjZDR9/7DXhbcIPDI5
         YqBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769014648; x=1769619448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzJlvh2XyLMGkwtl0QberzuQSLWoZAkg3qQo6w3w0Bo=;
        b=ge5B0OjkLfLhSK2DpLReHejXLwV1QPvREHWU9Vqt0qQeb8PTR2ZzSYhLFaacfZ+NMV
         ozfkEa9w0OvtYoNFXmZCx901Va8BNTO8rB9pwZp73gsVNUKfSpz/h5pXdDQ3OZC8q9PM
         0ihM2PbgptseCZtbTXfmCCt5iL7HZJcEkBXopEITsWJ4urrULGs5cjMMlLUE4gWXTcDW
         jHElAVoADgKWyMez3P8sKbluyw+aHVVsisJst4Upej+hqPNGBxTw45B8XObc1M34ArGb
         zmqGFVKJvcJa4k97muJnt16VdhQ3WPOwZeVLQ0qflihBYuq9aCEJA8a3Yaa9/KcHES6+
         uUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014648; x=1769619448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DzJlvh2XyLMGkwtl0QberzuQSLWoZAkg3qQo6w3w0Bo=;
        b=h7P9HDagIP1DRXJv/k7jEnxfDOQ7qahdVApDIsCBM5ldKH3cx7/q26/UyQJdL7QER6
         /hE/4uWNweRLOTGwJjc1Y1GbC9wAAvBxeS8wE29Hm+ZHqjo931cmM3kYpbhxDZyajbiD
         uScT0PeJb1dFS+3yc8ODYSYrGIidkvXDApxbOAPKbxDOngMUVlvhD1b8b3qh1kL3Fd7K
         oU5y5uIx/TFEpTUdDPN0IFnKlaa4/rreAEeGRcs/UbCBB72UAjliNsj/WALRQyftBKKp
         Gpjn5ODwwqnflxAlEnCmSWrd4VN10Rs1g2904K4VZpuPnJLfFiXovTkjASb28VnOSbc9
         FR1A==
X-Forwarded-Encrypted: i=1; AJvYcCUvccW4yCMX/yLWiYlVvCK22DXWYcFRHfMWgC0wgyZDIFSmrNPEAenGOL25ViJP8V67XKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrAG2af7p7iz4juM8tS/WPK6KD41Poj+f/frkeQ36YjIrdVHrN
	JAD9DzSKarm5tPrki0vWiryCi5i5BQ1PPCNGklJoiv1ux/02gGgBvven4/FLO503cWTMP6SH0tQ
	IT/0TJo790n5PCTjNT6KNFW57fihXOkn8GtIdLjtc
X-Gm-Gg: AZuq6aLl4poWY0xJc42Lv+n/BV/jsVZQkI5yCCF2QKjZ4Qf4nQ8ek8js077ElRdhwau
	H8w30vyQIk90CZnpHlu7DVIyzNAxdfc3IRPZ0IjfUuTqHFudaQkh++BSh+T97cr2bE1WJzgcEN0
	QU9Cc7dOAxX5/OxJHE+LetYGa29bHB3+wIH1vrjciIgHY2/eodAGYYwE3U18zrMie9SkGdbxfu+
	kqfOMyYRsWsoYLcPI2YYrV9ti8MfYQXk3XQ/0QFn/c6yVOi7yvQR9apfUJyFWUdhiEUaTak8hBi
	Rsrc4NGlGSTM9oiB7czBSL0=
X-Received: by 2002:ac8:584d:0:b0:4ff:c109:6a4 with SMTP id
 d75a77b69052e-502e0c0d426mr15219551cf.4.1769014648007; Wed, 21 Jan 2026
 08:57:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-12-5595cb000772@suse.cz> <yejhiw37av3o23z6s4oewlmhip3iqxxkkfcjp2jhlo4qf7nm23@hojkan5ym5cv>
In-Reply-To: <yejhiw37av3o23z6s4oewlmhip3iqxxkkfcjp2jhlo4qf7nm23@hojkan5ym5cv>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 21 Jan 2026 16:57:17 +0000
X-Gm-Features: AZwV_QgOY9Ovo2gtiQ4jhpdmFVjl8h8HKayG692yA7UEj4JquBoNIBa9LT-cydc
Message-ID: <CAJuCfpFaeYyzHirCYUPT0JDeavuq5UGqegW0OMata31XbYGnww@mail.gmail.com>
Subject: Re: [PATCH v3 12/21] slab: remove the do_slab_free() fastpath
To: Hao Li <hao.li@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 12:30=E2=80=AFPM Hao Li <hao.li@linux.dev> wrote:
>
> On Fri, Jan 16, 2026 at 03:40:32PM +0100, Vlastimil Babka wrote:
> > We have removed cpu slab usage from allocation paths. Now remove
> > do_slab_free() which was freeing objects to the cpu slab when
> > the object belonged to it. Instead call __slab_free() directly,
> > which was previously the fallback.
> >
> > This simplifies kfree_nolock() - when freeing to percpu sheaf
> > fails, we can call defer_free() directly.
> >
> > Also remove functions that became unused.
> >
> > Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/slub.c | 149 ++++++------------------------------------------------=
--------
> >  1 file changed, 13 insertions(+), 136 deletions(-)
> >
>
> Looks good to me.
> Reviewed-by: Hao Li <hao.li@linux.dev>

There are some hits in the comments on __update_cpu_freelist_fast and
do_slab_free but you remove them later. Nice cleanup!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Thanks,
> Hao
