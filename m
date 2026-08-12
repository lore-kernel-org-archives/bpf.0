Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572A038F957
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551590; cv=none; b=eQ9jxRnmpcI0DSEE2QEWUX6AubTpM/DWWCiadiYinh1mePwRzewvq3dGVk3uL2tYKuIDyO/1+T2mbRIJmuu6aKOoCraBWdndsUapt5FC8Hz0VeiJtEkYx914pCFw0ucrFQSatcaTHjwjaaZqxLnVImEYph3jYiVp+MG4govdRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551590; c=relaxed/simple;
	bh=ODqUEGP6tsnL1ThwmZZC1AqV0iSvLOGuC+8v6XhyXbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N9Mrf5RhQDFagi712N1GT9M+H/nLwJA0jX1C3G4VWW/TjNz5cWKlONGL6iztnVu6SXTKBjwe3P7cQIeZEwIKG08VawfP890PFFFb418IC8KTveLqdXxLkw7rL3upgt5GGf4sv2V3QNSzW7Uv9CPR2BiF8zmrsS+oa7c7rrkYEHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KY9huG1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KY9huG1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7F21F00ADF
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551588;
	bh=ODqUEGP6tsnL1ThwmZZC1AqV0iSvLOGuC+8v6XhyXbc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KY9huG1nNoRnvpCqjTFQgjBSywJRL/pB7MU/dPm08hgYzoS+Ieb9E8cEOHa+kAN8r
	 hpP7onJznN4TSYCa0plW4G+WA+o0rXCaPfAiuJJwCAz1jwRfjTaD0ZI16HxNNwR7xu
	 CC8Gd3E/kSJJMeOsi0KqyQ91UsrvslciFSqeKc6I+n44zIh6ir2sZ/V1u/426WCfP+
	 ppCHv+lJ/DixN+6mNR8pq9R0vPNKxmcp6q599RxrCVdQM+n0OSA0iSAd1hfj9WGU/R
	 eWqjLhjj35tszhnwQiQiv6jEEQ8jjtLxe8FIVBk1DWKmZSwAmhDF5XZlfofUzXr6OR
	 s18A7FxD7ICog==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e5c92c389so52811285a.3
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 09:19:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YxTOKz27IoS0jM/wsTjb8kuLoBDtFk/Ggwt5t+03dNXgHdP5e9P
	2HrqtZrAGwTPTsmnNuD4GzdxWRPHtUPRYa5U9TJ4ELy/CVkPBp1USnv8VRBnngrTLKQhBv8G1LZ
	l47CQ8s9Q7qOBjZ+zXIdC8lxgAtOirW4=
X-Received: by 2002:a05:620a:1196:b0:934:9f6d:8a0f with SMTP id
 af79cd13be357-936b3d3a56emr437784985a.36.1786551587351; Wed, 12 Aug 2026
 09:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812154328.72834-1-mahe.tardy@gmail.com> <20260812154328.72834-3-mahe.tardy@gmail.com>
In-Reply-To: <20260812154328.72834-3-mahe.tardy@gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 12 Aug 2026 09:19:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5MrfNwV_gwvP=uCWop46vuahyR8oXJsX2Wp70SCB-+uQ@mail.gmail.com>
X-Gm-Features: AUfX_myN21PcR5YwnQW31xiuSFAARvbx_9wPWczbCsBu5zLhf3mf8-CknypXsJs
Message-ID: <CAPhsuW5MrfNwV_gwvP=uCWop46vuahyR8oXJsX2Wp70SCB-+uQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/5] bpf: Add ksock kfuncs
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, 
	liamwisehart@meta.com, martin.lau@linux.dev, pabeni@redhat.com, 
	netdev@vger.kernel.org, sdf.kernel@gmail.com, ameryhung@gmail.com, 
	kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 8:43=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
[...]
>
> In bpf_ksock_create(), we copy the arg values to avoid TOCTOU races
> since the kfunc can sleep and the arg values could be stored in a map
> that could be re-written by BPF progs or even userspace programs if the
> map is mmaped.
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Song Liu <song@kernel.org>
