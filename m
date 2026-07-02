Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC8D39FCD2
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988563; cv=none; b=X9+S1M5Ye3eYfhSf9Gc63uS6scVYNqBbARailAZjgfLSYYbbxl6Br7F2gxo+NBXY/C+qM3a/E4xx4VVc/ojYCWF/qqwi8Ihc68by3PwsmJeBz2CgAkbzsUc436bVhrGxNAfAMmJYtjQqaOGEIoJwhms4NUKo2H9G29xIYL/bl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988563; c=relaxed/simple;
	bh=u78F4QdlrR7C1BYI5zDtdJCtyxUfspZXfPNBzuyN/eM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PcNfwjN35EBIoHBudpCpYJEzyISBIikmJ3DScIASZ/JxDw9Vsj1hyeyj01gofySylMHwW6LvoMm46hI9VAUj6L76uQPW0aNd0OWlRF8H1gjn2pobZSFV/ZwhT3jmSJ1/9229cRGiaODPlwxTWdVj0jfKmFH1eBAtVtNcGZe0NZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=NOKtO6Ls; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="NOKtO6Ls"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c12788a75abso301111466b.2
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2026 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782988559; x=1783593359; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u78F4QdlrR7C1BYI5zDtdJCtyxUfspZXfPNBzuyN/eM=;
        b=NOKtO6LsvoIK3dwQteCncaPJ+g6OcppeqhO2+Xa7XrRrDnbeZvy5DdHH2UutfGIVCr
         S/qkYU3bKmUr2e32gAzY1EhNJD8B1nrnHdcCz6BEJ1cC3R4fjw7FpukTx86ePzDS0BaC
         buJ0EfBWH4I4bGQKG07nN8TzsvEgrmylGq9sqUt0AfEgTX8OAMM0b/F7QMtZeCvjPWb8
         RDXgFFbgwrYUPQnNlgkipCiSMg/+5h3Y1DBUcKl3wG5ILjHi7di+v5NwxvmiCUWE8OCE
         Kr5Nt6+UAcMs3o0pbMx7lWiXQAiJgcyuiWJl64+r/UifjbmQCzoUtnuK+4n4jV6bSlRg
         71Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782988559; x=1783593359;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u78F4QdlrR7C1BYI5zDtdJCtyxUfspZXfPNBzuyN/eM=;
        b=ezFLzrhnbVxstRBOqXHh+cKPprki4W65tCeFZLtMXPy8mTfOntcmHkdkUzTz8g9qM1
         O/GmdKVvn6Ov26wPe0qH6/SNOHNMWY6TnwBad3GA86sScMLKmcXSxwfHZ8iyxKctyFr2
         +nW3QIFm48vBVf0kFO2b+2h/Y1t9FC27l0NRpcu0nxr0HcAD4A71H0LOqZgCNYPCNF91
         BPuBpMCds4HsJZiOa1s08d9+Zed62YYRPGygoLuziTic3U4Pxa01la5dL570T27Q8ivW
         wlNlXBdlIcsLphQksSFRb7W0LVFPR0oV4OAEobvsQGzmWXXD5xlN+1rdexa80rX9wQgN
         mClA==
X-Forwarded-Encrypted: i=1; AHgh+RoEJGB4WvfzZnvNZBEL0Dm6DZUc4t/afnmY6HD+/T9AFs8UPXYYQyBwlhlWLLU/LmqXf9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyeM47FUFes2gNh2GV9GLc4+cJhUdAYxonYeQOsHh34GdYDIaF
	Lhx3DN1n8XUzNnEeJ4xvj9x9G0D1zcJnUUQNKL+ggkcreLp7cmSAbXevG7BcN9p0aHY=
X-Gm-Gg: AfdE7cngZz2GEWCy2eQqYXPyYdGecYN/fxca9t1wbMOLI7EzTDHzIBI7+9xwjqnvYuh
	4Kk1ciYtpA5zg1mUWDdtj3iRYXlQbEYLeS3rprVqdP32w6BxaREHfhi0xoEi5JZqeuHUKaPHoOe
	Rba3kGM39TcLwUQc/luBe0/GIrQm9ZNYVHXGUGZRjtw9pfxtQa5o39r2mlMTWv5a6FQqF78Eu9Y
	aa+1ELzoqWdBGe2hGrObPaRa7EvklR9xpzOZOgm04U6Yk6oIeVfsgV1hMk9o2cCL1SbD4AebHTJ
	YxNhOUksT5r0CiFpRMsWQvftrhUAljc2a35zGHRxos9S703WhrQM04VUw0QoU8vp9sSBt+A6Ge/
	IEZQy8BLAIq79yL0qosfccD3L7cdq2DxOM0yQw6kz2JSZ7+ygZ5NICW/rbyH/sAC8JRq3xLY6iS
	3fhiBkEzNQJAvgtsc=
X-Received: by 2002:a17:906:44f:b0:c12:4f19:fad5 with SMTP id a640c23a62f3a-c12ae77c901mr167169566b.59.1782988559046;
        Thu, 02 Jul 2026 03:35:59 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62907ffsm107708366b.40.2026.07.02.03.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:35:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  Shuah Khan
 <shuah@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Jiayuan
 Chen <jiayuan.chen@linux.dev>,  Eric Dumazet <edumazet@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  Willem de Bruijn <willemb@google.com>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Simon Horman
 <horms@kernel.org>,  Cong Wang <cong.wang@bytedance.com>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH bpf v3 1/4] selftests/bpf: Ensure UDP sockets are bound
In-Reply-To: <20260702-sockmap-lookup-udp-leak-v3-1-ff8de8782468@rbox.co>
	(Michal Luczaj's message of "Thu, 02 Jul 2026 01:28:19 +0200")
References: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
	<20260702-sockmap-lookup-udp-leak-v3-1-ff8de8782468@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 02 Jul 2026 12:35:57 +0200
Message-ID: <878q7t3che.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 02, 2026 at 01:28 AM +02, Michal Luczaj wrote:
> Update sockmap_basic tests to bind sockets before they are used. This
> accommodates the recent change in sockmap that rejects unbound UDP sockets.
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
