Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F961553B3
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 20:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174918; cv=none; b=rNrp3QIFwA1oK5R5QHscxTek65vWgEBCJr6SIs3JJGw1xOp6bLXM98WKZgPGHxjdewWwweDHGwZAwEnegEk4DFrpYVGCqoQIhp31OD87Zyadq8xGtPfBa53oGhm8uPA4iIsAaFwVGf4N1xjZyFnnQAMpkIjLMqA8grAiavYWIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174918; c=relaxed/simple;
	bh=TM/Ol5Aenz4QqCvR+toVIxKjxHZCfJPJKQv7TNh80Do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNWCe4Fti6IsvkPjOGA4mi7GMxc8/cXJPv+6FcRAYSzrffFQuurhJzvDIjii5/YcXzd5EE5F7q86Tl3ALw97oXdhdJf9nyd8ceqL23zJiqA0IPEEcBGNRojPOZbdnw1HNvuLCl0jUq94ZiuEwO/KcJh46cPKDs1VLitro9L7dSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FH2PNL1s; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH2PNL1s"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-415446af364so8447495e9.0
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 13:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712174915; x=1712779715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TM/Ol5Aenz4QqCvR+toVIxKjxHZCfJPJKQv7TNh80Do=;
        b=FH2PNL1s0IPWgb/7bBONTuEPd/o94gXckZpH2PtqHuvDPVCtSIPobPTVuZgKS/T1SP
         j8cpQdmXTaGUYIQlcd8H6xSDkrYWaKtagAnXf2LWdfvgv8BiJ3/IVM0jPPhOYHL529mM
         1nLPWPLyjmFW9CbYl5KjXEMa4KXWZe36OesLZPPHgveOmBgvHh9N5/e4PNb5mnvFHPyM
         E58hoUi83yAyhnOjuRTEeWuUbT6+SivVSnLmiJkLwM/PnoFDtFMY31UrzYVuztDc9Oho
         FChxEHzEK0WmER7v3Xk/AGTEIsaJ9MFwkweTktWB4QW3c+R0iMp9GWkF8u+nhzsbkfEZ
         yfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712174915; x=1712779715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TM/Ol5Aenz4QqCvR+toVIxKjxHZCfJPJKQv7TNh80Do=;
        b=dIdiw3wjrIJiAjX/ZufecvMqoCl/H9FEY3fzaJ9q3OwyY8mataqe0eBgYDOcjKXyay
         O+O9aM9ZHoCZ/hhZgei8rUUcZYeSKxTgEj+vNf7EAQMNmtdhNfbBgAezhpqKt373YCGG
         LklaflGyRB4x4d9sF96MtJ1NF088C0pL4S9d0pL7oYKRU1BlO+YTpj/Q32sVno2X6Thn
         2ocWqWOzJE8iuwvPCN10T8Z0yVvBZ1qunpSbuNitCZZCSdlIR7ajfiPS4nj/V/JW7k+X
         wjRZ/gW9mID4LzE7Bu7hFJnV7fzc2e40zK7ZTprRcdRQAP8E2raAPZlNxsRilH5IDeMO
         Tiwg==
X-Gm-Message-State: AOJu0YyWtfIlkUL4DvEenuzy5fl+b1DR5aI3WK4Uf6TpOmZP6AzF5wkF
	SUUp3LWeZJduTja7g2oE//JQ2J1Bz/uZ+QcogOOUqUavQkqXBqOQ8VDO3Sf+66iBf+uK9RdB4Hm
	GLHLVKZBIZ2XTVnL1mGMJbZRyiA0=
X-Google-Smtp-Source: AGHT+IGCAiyNkyn0+lL3QOX23t2X4cc6aLYpSr1URcKm0B8n3Hr+WsQBmXpkVYntMfuytisBezAigfAuHCd+rWEivmM=
X-Received: by 2002:a5d:66d1:0:b0:343:67c2:aa46 with SMTP id
 k17-20020a5d66d1000000b0034367c2aa46mr3055773wrw.34.1712174914891; Wed, 03
 Apr 2024 13:08:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <874jci5l3f.fsf@taipei.mail-host-address-is-not-set>
In-Reply-To: <874jci5l3f.fsf@taipei.mail-host-address-is-not-set>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Apr 2024 13:08:23 -0700
Message-ID: <CAADnVQJ4dYRpNRuoYh8Bo_kW+cwuWWxcfPo7jruViGMj=U15bQ@mail.gmail.com>
Subject: Re: 10x regression in processed instructions after recent verifier change
To: Brennan Vincent <brennan.vincent@polarsignals.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 11:59=E2=80=AFAM Brennan Vincent
<brennan.vincent@polarsignals.com> wrote:
>
> I am not sure what, if anything, should be done about this in the kernel,
> as it seems there's a fundamental tradeoff between precision of the
> verifier and performance in terms of instructions processed.

To avoid such surprises in the future it's best to contribute
your bpf programs as selftests.
Then future verifier changes will be tested against them.
