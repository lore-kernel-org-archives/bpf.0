Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794598047;
	b=vMfK69lBlwWSDRPWRLE2IN59kik5H5bbcEsWyP06BCxvmNWlVbXKVqcBrScsrbT2foTT
	 1EU0ofpoN/bE3qA5fNz3u23ZuI3mvp+OJhLvyk8XgYzceBNxBuaALMYPwquAtpiapdu3p
	 R2gBuS2mqtR4QuhSWF+FyZHjqgaWl1TJQ95yXHSI+TEUYS5RdzfVWTYKVMPxPicirZr9a
	 MfFo05y7fMeUhsA+yafCX3u6AQtC2En1dX2tGLJ6RxOxb1ICs7ERRQ5wyeUSt/rQ1vr24
	 LI+TlBVD217uEhw/oHrU2WZzYhJEzD1R9ifkdguPWl5If1nUqq29nU6Yphi56l8hA5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598047;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rWNSB/aKf2gXUDjDW2lO9uiQwvj+Xxn71g5+dKmym3c=;
	b=1vV4F61eCTvrKuf0Enf6pn0PVKSlP0mlEpWQDFcWPuwijnRMB6ImBQJmibknnr4W91sk
	 MiBKkr0UdbK88cAlWzcrOMIN+UtlMe0A0GKlU+YsbS1RTlh50iXJTCbbikOj9mVOV0WUE
	 7End/AhXck8rJ4hkwyfGMFeB67zzY2BDu9fs4kLs1MbHasbXZeDs8ijGMTODDOsD8pXyQ
	 VNf75jEEjQ714pyALLhrIAv5LoE1foBPMD7/H3I5reHiespfetSqKSYa2W2qbJDD24T+f
	 xijJr4jA0bkNvvgu0as2KkTx1Cw/Xzu0gPK8FSZRtBjezbBqe8k5VKJYes6HP1WOgdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gL8jZDdW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CC606A333
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 19:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A6CC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gL8jZDdW
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b791a4b732so1171a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 11:27:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794598044; cv=none;
        d=google.com; s=arc-20260327;
        b=rQLd3ZODBmQslwP0/JciJts3qBLSa59w8PHwVf4T3QcCFbNjmRkdzcpZ4of7TjDfnI
         AU8A7545PvHp0aJgoZGKCcNaauFHB+zlvQqyx0FKTFqHZAZ++Kz+/sSvTtF3udeDMhoQ
         wGpDojV4nAXC3To0rkgpiwu2qPz+eVWpC3FHTJ+l++pjAC04r5db56J4fKFIyt0uBYFr
         AfOnJ6fRK8rA2QLfRbvfdX+ukzfaR8I3sawh98t4DQCLH5w9vatek3Y/br/YgtYCUCMh
         AjBhf4gDDgxAhOhEpeJ+mCdXifpgqnHs86T4y78Si0wY2lyVvNc+n2L1DpLGjJoey/a7
         Ac/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rWNSB/aKf2gXUDjDW2lO9uiQwvj+Xxn71g5+dKmym3c=;
        fh=Kp6BBcKmUnCsiXVaYM/SMajJXBn6Y02r+NBT9mjNtxA=;
        b=TZlGXK3vZDEgXN50uolnrZSD/drdcBhka7V6ldSkndS287LecAYH564cOObVMtG3Ag
         7Ay8aLh75TU93iSSp2/P+RbkycXuMEB0I9cIAsiskiiQPn1vjflqCeiqAyX70cJsmzR/
         jvc0UcUeMcspv0hntJhLGlBmvg5u4N5DBUfmA5Jda5RpAdlymnCxTseW/VZ+lLqVfLmv
         njT9ZorFiSv8xkoUkeUSIx+CuxUQ8iRDT4WalkZM0NpxoXdukKeFv2d0ai+fvKyk9Z4S
         JCmXKL8oYmxi/weQ7x51kSeZ0dlyS1ou3KCsHO4l0oaDbxYcYhZrnggmhl274RGt4xWn
         bIWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794598044; x=1795202844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rWNSB/aKf2gXUDjDW2lO9uiQwvj+Xxn71g5+dKmym3c=;
        b=gL8jZDdWoijYOUqqlj8DOAFvK6zCt6P1zN7hO5bgTFypZZ4sQKlyeApMVL5tn//P0M
         6kW3UYi9iCdBDhHfk6wKFTzI+2CfsAFBw7Rqv9Vk1nFOxXNXN/aD1X2E3ajfnJ6UGuBm
         glDsl536MTl2iP4zdDhrwJ/LeGsb/n7BT1C7dJ/ov1VxHcpDm2TAmCZoixEJlYoKVorI
         ShfqoCaCnn5MgtpAfxRcrwijJhRmF2tjMYr+EO4otzUnXlUcb3HThkZkliJTv9xT5miG
         cFjd4sB1mm4TKPqC2fzbcGlemMbI6HKTVpEDf72EISt32sXh2M3a08l80d0nxf1IFaH4
         Jg6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794598044; x=1795202844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rWNSB/aKf2gXUDjDW2lO9uiQwvj+Xxn71g5+dKmym3c=;
        b=BLgbOiwZEZM+vQXwe1wrpRvARJzMIoFiyE/geVmKrHj5mNqzq/RC6GMtQNjiIuQtNk
         MDiJVbdQVYRjxSR0a2ysyTZ2boCbJMgaEipYh6652dEaN6jFnqchXVzx/Pmn+odrBB+g
         kA0zcymJwXpIl1OQHieZp2znYbUqs9wkvtOZtFP3pPovI6tYS2rF0YEzNFAXPI6BM/C/
         7Qj44OVGAEOnFlX1EkzHUusaAdoaJCty2XxQlO0c0Deykj34nVpKKtz7QVZzmNipubMk
         v266Qr4g3dKN3TpmR/ehPzHOjM55nFr1wse6Il8eopfWedYbBbBaWNB4k25uyxYPofxh
         OOMw==
X-Forwarded-Encrypted: i=1; AL+hErEebFomoHu+ulVYVRy52UwOxwGCWnjjvnIdKOs8vF2WsCF4zRnH2j2Qr2C85P4CfqvFBIg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZYZUOwtZGO/T5xu+QiyYL8XsrHeoiwUnau+VPDzaRc2WOPZvM
	VyDUYKXiW1Vyp27PwA0SyRgBZ4QIfQ14saYkm9L+bZEGGhKuWqHSVK1v2zYWncChvgUw4xMv0az
	ZKzyqusG6/MM7jt+gmPttHA+oywvI8BkCIGCzc+mX
X-Gm-Gg: AYBFou1KP3MO0hUmBkjrVL/JZ79SO57hXoLkEmzISpJQptf9eAl3UVAUma7vsvfiRVN
	Kx8XBABRCDOS2x4jdKrhoizUssO93VLdbfS6Qp6yI3bO+Y/CG2mESmam3LXeDsMtjkwPDs9u7ud
	WJa9SYZ7Tad+f8YE1JkiXAdfQN4RhK4M+DvMW8q6VI74xzL/7b9xzcvImQa01k8QpLMIOH/wNQb
	ai2zsTC/RUusXtOOPwcx7PjwUhOSnR0pF0ft41l26tjL4SOB9QCP6VC3JyF2RfnQWeqJO7USZC3
	aiBUyvFE1nK7w+nBUIyPXfKn0+4RrhPZm+UqOwLN0x2qyoYqBqyMFLi1O4V3Q0ZWdOEWP2TW2wN
	xBqLy0gpd18wOl8ZEnfpPVT6HVqN1bHm7c152KyrnYAUI8sqMSKPKLnaGCWkmQyGXpdo=
X-Received: by 2002:aa7:c60c:0:b0:6b5:5d24:5d90 with SMTP id
 4fb4d7f45d1cf-6b7e064b605mr11515a12.3.1794598043562; Fri, 13 Nov 2026
 11:27:23 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110102039.1002605-1-bjorn@kernel.org> <20261110102039.1002605-10-bjorn@kernel.org>
In-Reply-To: <20261110102039.1002605-10-bjorn@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Nov 2026 11:27:11 -0800
X-Gm-Features: AclHuK8F8Y_DVnfmHCZelVEZmvLdtuJXie3zRJu-e7GqKDc7mN1PxeFQiqOooCY
Message-ID: <CAHS8izNyMM3pSJJXZga+OL6QMHFgnF-gu-+vzk6DO=EC4CLfuQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 09/11] eth: fbnic: Use netmem for RX headers
 and XDP_TX
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, io-uring@vger.kernel.org, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:22=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> fbnic reaches header and XDP_TX buffers through struct page, which a
> provider net_iov does not have. Use netmem for both, and set up the
> xdp_buff with xdp_init_buff_netmem(), so XDP_PASS copies heads that
> must not leave the RX poll.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

Acked-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
