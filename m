Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789462;
	b=lhv7QRGcVUFyxfQLygJGDbpvi9yKbHB/CxT/47yNDWteBBuDNjSsX8Rp25QOnJBu4aXJ
	 agqbOvEt58IuKLZs4MINg+sntksIDFmfVDh01AfZFMr+QRhhYrCo2XRWMCXlXaYmPr5Kn
	 qZMQsamLHWuI4O6tqbArFqFBLyBFfD2NEczvrB2m0VKSHqRWxHsfsqmyJfrN5TFZXryyI
	 xJN1KL5arnf/0zMERzWqwurcsRI8n4ozFVlU8vjdtbJ+kSbD6+4D5Q/GyW/7+1Zb+4Un0
	 u6vYTG7cKQX244azgAZrYGKeOWOxTm62NAjExgbqT12TpAicHKIOAnkvfSlzOU1ZSFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789462;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=TQ3GVVAse96Zvj6V7KUiNZCKQ2wZNqbJyI/5ZfB6em0EqBrMwMNCJuGNyASNk9FpK3NY
	 cGJJtxibS0VDBJrTF8WJWqp+RmVzenafKoP8enC+xE7Tgp3Uinvk5NXcW/0+WvKuvBG3x
	 i1GV/gIY82OwqPjGjAwxsx0h7tIY6lfYMTRxOCLC1Twzj7a4BgHlNHW4Uh4fm/0bEfZee
	 WMFWqL8Qc6zqfv6jzjwTIjWDeYAzPRPbE6QmfhMl4gKhXd3NgooaEXqiESQBKfjoeuxXf
	 KZEUrpbXV5m4bLvqqLy998gktt8onpyCvwlbgR1Q8l7Ck4R/pFxfcIk20Fv2DVz9Bqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JiSaHsN/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA4606A689;
	Fri, 27 Nov 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JiSaHsN/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6389C1F00934;
	Fri, 27 Nov 2026 14:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795789462;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JiSaHsN/eSaFadoc5tJ5VpXhzsvdCL87P+2sY3nhUY+cxtvQ88EyBcTq5fEP8Aw7F
	 4vqC+aJOYByatEIRgQoADHOEfgTfQCjZ0wwKW3t/Z1Us+yb0Hmg4yf63LNY9og8WeV
	 FuJ0ll92LJW0f//eDjv0hmdIceQRUtyXwxrD4mse/tfrhaDuJWDPXFAFTQy5ApqlMJ
	 jxW/4yJ0rh8s/EIfYop/r0Uom2+Goi5WNdYoxoG2e/xqUYBy0UEMcXPp7NGSqcU1AY
	 mMnSgGTjD/+FQ3sN+1sUFINBNvtR5sV7EniSzic+IXxVQch7GUA6SHPE+LRfXdb2Ke
	 2xc7ddc9edrWw==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Colin Ian King <colin.i.king@gmail.com>, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 0/3] xsk: Keep the shared info of zero-copy buffers in
 kernel memory
Date: Fri, 27 Nov 2026 14:24:19 +0000
Message-ID: <179578945993.3294.13218544631013207467@kernel.org>
In-Reply-To: <20261127142131.3527737-1-bjorn@kernel.org>
References: <20261127142131.3527737-1-bjorn@kernel.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
