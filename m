Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QmlWytzq"
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6459F19B0
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 22:51:42 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so559493a12.0
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 22:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702536700; x=1703141500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHsxzvl396B9TsbSvTEJt3J2hBdAgjNAT8bOMCH4v2w=;
        b=QmlWytzqVq06JId4vvsAOd+KdSEMS5c/WnxMvozmd9Zc/rUYhH8nxf4/SprTqo/PAa
         FMril3eTCi3P/YNopFkbvrEvvzTmEVc/LTb3Flt3HTnYp4rAMqQZpdWE8/41UgnH91RF
         X/P0hv+qANB63ijvGrWatEI9eOLQvo1NcYunqeaaTHFkm5Cj7IXU0tdS/RKS+TnHNT+j
         92ATNsZ4ep7rG4CifKFxkThBmoou2WoJA6OQ8U8VntHiRJd5RoFUvOkFIluDSiREftNY
         k2/pMlonAvWFk2Y+ADnAA4unKBQ9qZuuns4eDTaOGv17odY/u+Of9a7H+hVaZtA0EKgU
         Wd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702536700; x=1703141500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHsxzvl396B9TsbSvTEJt3J2hBdAgjNAT8bOMCH4v2w=;
        b=SO4YXn8BHPyQDS0Cc6Ee3GuCqx0uueTEqKsJArSivajklJ4XjcVbpctLA7Hx/njJJw
         G+Os8/S/3VL1Zm85X2IVGPdDX9y1HW9zxL+lq42cq8aEiTnl7m8dfBQZmyEuMOtbdAO3
         k2Q+9h2VgpCtddbRaubSj/tQv7NioQLQxmDBks+fKsQE++rp0hUOF6NlGcDeTur4C8np
         o7C+nbB9gZnMOFtvb8z692uhGIakkIXT0XUqCrQhb4ZX/I7LkBQ3x6YjIJ3gYGqf1clx
         YgX2bOUIYCpM8pNbiEQ7g4IKuPiecpJuZ3RBJ+VoecoolLkveZsuftJSzXt5o2TOdtp5
         Ylhg==
X-Gm-Message-State: AOJu0YwafPFfB2N8y9yDHg2YE1Qe9dqM7McLPMoiYUYOslxSrFlL8azM
	jpmmWboOVb4qrUfytGngHI2jxs1xV/AcRSendOY3Fg==
X-Google-Smtp-Source: AGHT+IFhKjoYARnFGO13ApN7eSk09nSCJTSeKyT66yoX39zQ2bSsEmHScKXeMW+UKEwtUalYt70IEOQCcn29bH3NZ24=
X-Received: by 2002:a17:906:5197:b0:9ee:295:5693 with SMTP id
 y23-20020a170906519700b009ee02955693mr8600960ejk.7.1702536700141; Wed, 13 Dec
 2023 22:51:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <170253482786.28524.10625748175644260187.git-patchwork-notify@kernel.org> <ZXqlWT2JYg0sa7IF@infradead.org>
In-Reply-To: <ZXqlWT2JYg0sa7IF@infradead.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 13 Dec 2023 22:51:25 -0800
Message-ID: <CAHS8izNCvxuTsKV73oTu3xS7ZVr0riBdYGbKnsHptVe_e-t5MQ@mail.gmail.com>
Subject: Re: [net-next v1 00/16] Device Memory TCP
To: Christoph Hellwig <hch@infradead.org>
Cc: patchwork-bot+netdevbpf@kernel.org, shailend@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	corbet@lwn.net, jeroendb@google.com, pkaligineedi@google.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, arnd@arndb.de, dsahern@kernel.org, 
	willemdebruijn.kernel@gmail.com, shuah@kernel.org, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, linyunsheng@huawei.com, hramamurthy@google.com, 
	shakeelb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:49=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Dec 14, 2023 at 06:20:27AM +0000, patchwork-bot+netdevbpf@kernel.=
org wrote:
> > Hello:
> >
> > This series was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
>
> Umm, this is still very broken in intraction with other subsystems.
> Please don't push ahead so quickly.
>

The bot is just a bit optimistic. Only this first patch was applied.
It does not interact with other subsystems.

  - [net-next,v1,01/16] net: page_pool: factor out releasing DMA from
releasing the page

--=20
Thanks,
Mina
