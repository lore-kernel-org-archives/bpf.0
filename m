Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507F2ECEBB
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 02:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740342; cv=pass; b=D17HC2XY3sxYyZ8Q1Jn14bs9pZ6kKx8vyHkBLISJS+BRgSjA5TM1hCfMfddneS1y/ljiOThhOshvrE+a4Y0J451jUJRvSwLV9XY09iMgFUoeocd3Dw574tFOr6pSI5og7CcQhtW7GAHoPBzLZjEeW5ExyERV8rLhysY8VDW9qso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740342; c=relaxed/simple;
	bh=k/aDS+0oYH5HpbjfW6HjWYN5iso/Y5/50MxxdlYKMOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzVZWnzUUxQVCCeOkV7RxlIuLRYVOWqhIV5mBjAz6NaIi80GlwySr3iybtQyTuruToTexe7Cbsn7/mwAJHoMsHa58AFsZjk2RzVk1JcALVtqeV7wBhy035CGzHTrozCI8l3+SmCoAOvaB5mlAVq6m6mTWcmfAk+itRcAPFk4VoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2OgaRGK; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2OgaRGK"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fbc305882so1063639f8f.0
        for <bpf@vger.kernel.org>; Thu, 29 Jan 2026 18:32:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769740339; cv=none;
        d=google.com; s=arc-20240605;
        b=MuBrCqEanuMrrLrBktP55nLkXr1KCSgbmSf1jTJAEQ/mnndnmXdb7rSGjEKBRZLbHv
         cq9q1jTQaYGOpqtB48Yo6ZVnos3W6fHRTQMB/UqmOheD3cJYB1FhlptmFCx1mMeXSZUM
         9VE7IjV5VZi81OfIAOQySe9SEx3K5r9HcC+RCJQe5cMy7Y73b+ToCzpMt9lSrQiisBzM
         px40GLgnCmI5u6v9LP1oK3r35mjQVrOF67vLTaPf6ehx8hlTRB8Wz4VFAs9c3V86hvsV
         TIgvlAlCltR9w4yjXXifvsj+bledCggNBFWV12TE5D4cXNmcIy/8DX5mO6twx6LBXh/H
         rArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k/aDS+0oYH5HpbjfW6HjWYN5iso/Y5/50MxxdlYKMOM=;
        fh=d15VCG8OEfPtRSNrOSTPOQfis/hfBhlYH0737DJxG/c=;
        b=cQHUe0yUJ4NOaJP7KFcmZ1OiFjgTCsOizs95tgrjgqqMKUF3/nIF7LApg9XFWbabYa
         IPDeCgjlPyQSEt14kt6a1o8vLR6DKmxAbgsVG+bovA1NT2BOKpKav9OXERyaLLXc3P/F
         IvQYr5Y35T4G7/+6k13pdokALohijA4q2DpjJBJEUDjiXdfiyE7AxbStWyUk6TDn53tp
         +Z8/H2jWfcMKD1e8ajVMpzNYHLVqI2WIrX358chCgMF04q/7OqlcsvFSQkuSu0JTVOqW
         giQV8fj3fBqbiZimvp5d9YVRmyj1N0KT5dJgkwiq6rtlxMMZUf8Al4BlIYpFYFyla5rn
         F51g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769740339; x=1770345139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/aDS+0oYH5HpbjfW6HjWYN5iso/Y5/50MxxdlYKMOM=;
        b=H2OgaRGKi6ZDrJ37aMl05QeaRRYk/X4JfFkhGVHFT0xghACtcEN3Zb0aQvt5HHJncO
         3q4rzn1HqLdUH2dEGwR6vnj3G4c26SSdaWTwfBym9tmlxmzNpsg0tMqasmH4HZqzS0EH
         6kTMA8BEnpJAS8IBBnjeP41+TQkf9iIhjXvo8lm8l6wfDD7xnkf5q6V+ooz1ZxCRGX//
         VEvA4+A41oFgr0qJBbD+/ziHizScVjf+te8xymKYoslOtEUxIudlvLgEVWQcWi6UPT68
         e7kuLOnrluRkGmRm16xicZeWJnnP005Fat+aR6f5PZYChB1jKbO9tR20V5CEs7YTdAYH
         vsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769740339; x=1770345139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k/aDS+0oYH5HpbjfW6HjWYN5iso/Y5/50MxxdlYKMOM=;
        b=jP9WUQGfi+0rUfbNF/WWgm5WltIpOXK9AZ24jKLS9eQXePn2wW9tWdimftFAdEkcK/
         n08FbiKJ0mYtdt9e+HOy3ZCh7dScdOtkl634RNZqH7TqRh8BFwndCcuseQJhl9V5uHww
         n+djhzyCpcxhZ42I99Mn6Uf+yXRYpOh8/0sA/zgz/rOz3HiWiJsKkmudVuJBWqW+X2eM
         v/RengOvT4zWgWdmgcr+usOooKTAezaS9AQypAu+XHqLsptc34sXwT11GyyIxSo6F41Z
         cvGjIUGm67EVv4yb6185R0CBE+ZgD0PiddMGHk3KR72Yfc9Uu/EXVxFBVpsfs6rnsfdT
         VKoQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+9319Uu3QTxI9aXtuLWIP21h9pDhleHc466bQvfvN3gzkWB/tEVuofFlczIBEnmos8nY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQptkJ5EWeioam1YLRtbA4TLq/NBp0LmjsgqkxObBEMw6O+d80
	E3PjIsHxZ6RdPKgluOB2VOTgRugEABO7f5rjLvBPyUe2AgiLBG24SGCyZQxRhV4djpTAZvYKMtV
	O69JTLZS/CZSYuFOnOuDYbaviuR2a4H4=
X-Gm-Gg: AZuq6aIY/IAgI9jZZbvpt1hKl9mLQmKuoioVKTtyhyV2IzHqIBPN1vMzE28vJe9m5mQ
	h2J1MwTZuTf8D8Vu/EMu1RiNxcecdlSjyUbUETNE/u1BQGuvrwhOecE79mzcx6JR1ZIgD1o98Tx
	vTGScX/zzmHo5nQao+CDdK9NzQhyyQkXErvzi8UMduN0RwsamcxDRwcm8scPDe9htir9kdTLRJ4
	JYInA3dFwQZ59N5JTCZBjbtlKKWFoMtFcEJOunr7Rz+zJokOxKGLvLfeqhldyLD6aSGBQNdA+yu
	rSJXOzpx8E8oBp8rDzAkAjhMheMf9IjffJx24P65EHdwI6VMwpKqgHkZj1kv55NXah9LPK9mTJH
	+wUyBvRAJgzMQtA==
X-Received: by 2002:a5d:5f51:0:b0:435:97f6:4f44 with SMTP id
 ffacd0b85a97d-435f3aba452mr2106682f8f.56.1769740339363; Thu, 29 Jan 2026
 18:32:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129035014.3283392-1-hui.zhu@linux.dev>
In-Reply-To: <20260129035014.3283392-1-hui.zhu@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 29 Jan 2026 18:32:08 -0800
X-Gm-Features: AZwV_QjkvCynu0iwUVBI8BI7kYSRcpjxCSWpTLRoHPDF8MFwQngmzpsXdmYVjRo
Message-ID: <CAADnVQKGci3kJW0F40j0tJn6=ma-ACEzcYOcxYE8Vkp_Tif2hA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] mm/bpf_memcontrol: Add missing newline in
 pr_warn message
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, JP Kobryn <inwardvessel@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, Hui Zhu <zhuhui@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 7:53=E2=80=AFPM Hui Zhu <hui.zhu@linux.dev> wrote:
>
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> Add missing newline character at the end of pr_warn error message
> in bpf_memcontrol_init() function. Kernel log messages should end
> with a newline character for proper formatting in kernel logs.
>
> This issue was pointed out in
> https://github.com/kernel-patches/bpf/pull/10864#discussion_r2735018210

Just spell it out that it was found by copilot.

pw-bot: cr
