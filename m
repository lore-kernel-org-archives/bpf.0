Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353603;
	b=PLKheOPs6LlQdka5KU278pQlDV7eKn+AkefuYOQ5aRHc1fzy2FyQ4yEIOsY9jqw1yhQ1
	 AwTO8pVj+GEqapUl7UUZG7+u/QRHFuZBsTvImfRuOZPzl7TkL2XVpJ0d3I7B8gYPrks7k
	 E/UOadTBvFNoKmPqvAuXBfDCl8c4eoqu9qtzUfNYmMfEdO/kqH1o8KGl0phTqVUJQZHdL
	 yHDHyFFhQNoPcYHBzGUHBE/btyguYPH3eBWMp/UyrJdjDobXux7jN+RfK+1RUu4TtpogE
	 hWibiP3/Vq0sk9/LjLJY9gh6lO63OKQPg/RDSksuFeJI3Gm6z2xEysOsqBcUpv1Zdnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IOz4ue54IuUUiPM1zk33V1FdxBfzHmxJTDRmhyQa7XU=;
	b=A118SHEuRhG0COE2kgoVypTH9LIAVfXIm26mjqVHM6uqa4+HzIvkraDtcb08sUUK/do4
	 5ziID2SV+2Li+Lq8ul7DcK4uLBNulVb7UqL1fnY5WoiiUBBGWAaFI79dlUHIMTgd8zaSp
	 R7eNpT+5n+iZnrTVrHcMP+OZFM4Kfdh3wd2XugSmWcsTLktCmRCLkqMSRSumiteLStqOj
	 49i1r7yGTYuOVcHIatIdbzfnVio9026enEiUOW7BioOpy0Ij9A9Uyc51LXS/wxQgDT3xq
	 O+O6C3e8aIqRUYg5GkMnbijy6TgfspJI1Q0WY+JPgMniluLU0sywRkuEF1iCjyjOsXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0kQNarSx;
	arc=none smtp.remote-ip=74.125.227.130
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9826606A31D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 09:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9826606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0kQNarSx
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2e651c30dcbso2873505ad.0
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793353602; x=1793958402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IOz4ue54IuUUiPM1zk33V1FdxBfzHmxJTDRmhyQa7XU=;
        b=0kQNarSxZeE3Cgu1GV71IQdek42/dUZi3/owzf5Vhn4qSxRd1DyUIgfdlVEZ4HBb/C
         VYM32ZLAbj4dljoJS/GPhetwNEkkYloNNXA9XdW28TQUKhX4pJl2aOPcutJ2jPZWxPZJ
         mA6uT/BkIi0JbMbAHv7iJAMvQWG2CgRcaYFqne5jC4z/7mQcojmPslt2/MvEyFG43Sgv
         uWg7TF056NBGJI33kAGa0OSnk5APUaPUzs5z0ECZD5fukdrTttMeZCjrH5IQ1zNCrBjj
         B4R1XvC2/XOhfJiEEGil+7LysefNDT2yzXI9kEBdXd4K2FOw+x+AqPbqaPAPhvfMbWNl
         bN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353602; x=1793958402;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IOz4ue54IuUUiPM1zk33V1FdxBfzHmxJTDRmhyQa7XU=;
        b=INCFGllwXghuYxs9dO5RRewBd6TTvvfJLZHEWuVLkBiX0LywSNkqt4WXM7hrD3/Xo2
         dF06L3e5hoF7s3n9v9q9Qk6ZJi9TxdbccPxfFTVWH+15GTEU/+v1BaIlQrBnlt7a1xdx
         dfyPOjn6Kfb0RFzwTwrj/qrtxx2RVk0iXz2TUKMn0kZ/ajD+1pEoqSTu1fMzIlo9XTKK
         nnRXzwTVkBXANxfFC1yLTyHiCNf+Pks6Zwkny6yqgxd8/cxEVFBQx7WHo3+NvNp+UIxq
         TOWt2IvQKUPKBW3/okxJbpVL1GTvVhc9SFiiB4yO/fhgChz0P2n3kKwQL38f9F8gUTyT
         O1Qg==
X-Forwarded-Encrypted: i=1; AKwUvBxXrUU1RnYrxIGFy0N9BScUgozYUMhaLqO4ZrMOTMKF9UnES2/SH49jwKSyFQXw4niAsmg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJv97Di4VyAlTcaVdJ2IJVUhro9fDtioxaP3fYv+4q9EbtWqsV+
	XvXyBWai3Hi3Lar+QD8Suhs4Vwv9B1z9Rak4aZgOLjhY5urqJeHpfwi3
X-Gm-Gg: AYBFou1DCnFftnSyI3y/NsJAvcQ9NmhaiMnLBnIHzpj/6j8JdRKzTlAorQGONHTTWc3
	g8lRIgEQXxBxPFW5w7WCJgdQOFn9rENyEwcSnI6gwSq6F2ymItbLdGt7p3j5Lnxd3wOUyTpqT+3
	rJfuKYqUK4gPHh62eTtxk0N3ASz7Mr1KJhYLgMSHy58cCK1qc5GxHiJGNQTZKTiM2xHpwfWStjt
	+00kZXcB/7d9cWYnqnfTvr8ZWDnXbYJwfyR2IHu53tAYYPnvBROhb7FUrxBQcrtW5dBT77vLV41
	iHM9mVJfuhGEwwGMQ0rKpvTxInToarcxY55h21cB4oTYpSkt7PtYh8cug4Nedz6XCYk/i0W+Bh0
	NeZ+gdUAM9m5o8fliFNKpd1ZggED+78u9d0llYBPYAf8MImVlfNzEK7ZJmO1FOdoKN9Ryq4wD5u
	KdLmBaMgQ9+4kxsq3puU8xcvQiATDNBqM0HGSNBYTMCfofbylWhQ9mfmv3Dx54dycnw89Y5vl7D
	+HbZdsfNLOgvy/zRkPeLHGIdA18ZuEwqmAWaPj797AhpuMAsx3AcCti//cWUMlVEocJTlmOBwFA
	WxpAICWOYlah+8wEvBUd2qUvTJNdU/Q8Z+vZvPvBp0/zmjwL5+JM1eeAJDd8C2Q=
X-Received: by 2002:a17:902:ef03:b0:2e9:460e:ca49 with SMTP id d9443c01a7336-2eb3649be5bmr20449825ad.18.1793353602042;
        Fri, 30 Oct 2026 02:46:42 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2600:2f3f:68c5:29e3:ffaa:7181])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392aa7bcsm4998055ad.67.2026.10.30.02.46.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Oct 2026 02:46:41 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
Date: Fri, 30 Oct 2026 17:46:33 +0800
Message-Id: <20261030094633.27910-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com>
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com> <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com> <20261030084017.16202-1-testwrzwrz@gmail.com> <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jason,

Makes sense, thanks. I'll wait for their feedback on the selftest patch
before sending v5, and fold it in together with the rest.

Thanks,
Rongzheng
