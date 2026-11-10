Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283049;
	b=EkECEEyZzE4FtRgOvEdBbJC+x7b9cV0FO4d2W5HfdIYnYUEDA6ESJb7DU1CNlsw7QpeX
	 q65x88Fr2oqf4IAZ+n0Omrnap6kJAx1gImbptnsvql0O7dIA2IVbLE6HuMZMZq0p/LcR/
	 Ht4MuIjH9lvC8YDAAHhVwf9QhIb4C2YJA4C1+cEhZT8P7m/yyU7t/+qVkQlzm/yZwvO5d
	 fXd2DNwLlJQO6ybPq+iezxuaTI7ucu1qsw3gq57u5QQ6zb58Ih8/Il8ZDxUCYgCvQnHDB
	 CTZQfqAdJcuSnG5zB3j03PEJbS2OlTsNyXmkmcFS5Gv0vNaSJLzO2rUWVGnB9MFbp8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=L0xaW/62AQgxFhpajczQ88yBj65kDwjYHTXkn62rfdI=;
	b=bfdwFZ4N/pdbNHhKpz+zd4IWUe7B+jOvTDWMzZdzjjpeDrWSybgfO8o9GK2tZOs24kA3
	 iLtDBBIK4Tc49+tPJirB09mEQUy8NV3sR/z0LCVRIJil7CbPjT4v6wqAgzmbN2kw32joT
	 jj1MzsO1r75E468mDyb2FRmyOuTdJ5biPERU7ZwyLOwLkLnJ31r06PS8aC3sxOJhWSOeH
	 kjZKidkuEc74Lgn9g6JX7QM4tIvFVZ1U0sstU6e+jl0gV0Lz6nKadEjMcY7bqHbWsBJkF
	 auhWulX7HyqVPf03QmcsX3OlOfXDOwCL90Y66yFiYugr6lgDJ+Qb5az9E2mVN1Lvzig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=B3UO6mYx;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBBD606A335
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 03:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CBBD606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=B3UO6mYx
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b70d5b07faso1938719a12.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 19:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794283047; x=1794887847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L0xaW/62AQgxFhpajczQ88yBj65kDwjYHTXkn62rfdI=;
        b=B3UO6mYxBrwbI4EnQx2MJCfYep/7lzLJy9J27S0G6O4GvtAuldRznLGKrqfTHxZKwy
         8pAtP29K6ylA0zEHKeGYXZl1w2XVzbwIam1ss5NxCX8JGel0U2a4/TGaXtIpR0G132A3
         SIjYqB5LYtz5aXQMa7VQHXjfgmJr3DFNg2bM/m4fG7KjNqLt2FW6m7RDwNDQASs5rDSZ
         kXe3in7HjpLK7qHJkb78nOsZ3g1a7uDFw77n7dsnwPZbZ1CFq2cf20jyuaq6hsoc83El
         MitOrxLYK+ko289aXFEf6w8Z4VKwqe8agX/YQQyNSRqsQLap+MgSPkjtzgAl0JWzJaWj
         k/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794283047; x=1794887847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L0xaW/62AQgxFhpajczQ88yBj65kDwjYHTXkn62rfdI=;
        b=kkapHIgbY8WujNTPpr5/Z6nt6xFx3xaF0ltwvphFTzkiCDKaMGneQHqcTW1PFIn5Yw
         hs2FQ+ZZgO1BkY5GdGK5KulhDV53ihF2uFRSrMY7Fqm9C/im8auTsS0DjuIf2Wv7Wcbj
         375EIvzi5SA4EGha763wxNO2pltcyvBYkRUx0Iux9Sk8WF3LqEkovgU3+Sr7MQmSl3oO
         cbrHPTxuAj9IQZogCP1M0si460saKA6gpW5iaJLnUPVHW9M3OXii6qA8ugRop0FG5Iov
         SYNGWNIS1Zz6uvlGUSGk4/SqQcFBCAPwr8jlJPERdHaiVOtO1P9F6/+70MznqVHDMHaP
         R0dw==
X-Gm-Message-State: APuU4Z90VQH6XHpD/sU9VcWqU0GAxuVOb0Xmq+l2kMRq5OSpIIp5P4Xy
	2w7jr4PleDp/h7rtcYPEabN1IJyVDYh0UrhGH4IrGh6pXXz2NoHkmSwnzkLmgpZ10Fpq/tgLDyr
	T15Tv9WQ=
X-Gm-Gg: AYBFou3K9aWDq7ECjw77jiIPW2158ORxkJ04MlFl9I7tAsHv2iKsHV9Q9ItSkmtXtUx
	Zs9GhMHNJUr/Ra805zmRq3xEY04DOv8tH2tpb5Ot8iPIlCcYXnGH7X+BFEX+rS4xy4sv5frQ7o/
	GrEilWziMzXcL5tiB7CPPzx6v3uiOFPjlUcmk8IUTxMS8kRLbSaM8DYp7hzY9tBWzaY1WqqlZ44
	Ti6Dtrg8X+sR09oMRxvWLbQ1dqB0H8zOUOlKTtJdw5HII9S4bWY7y0KgzOYAKAEbwXm2tf+LY1D
	+yUmdG9hKYDA4PvcKrkb8xxSDOTr6j87ZHQ4QaScS6DJsv05bDvftavezRr8eEeJR8oVIPYMNFB
	Y0gUfGX1zRM7er/GRDlLZrBNffsYnQtXFTIMGoSHT5RnyEGLnm53LNT9DXJiVO05S0IRs1Nqlsh
	8mAfmn1Saxr0wOT0YPiM2biSz3FaS4siffjHXVw+OS1PEkcHBaOB4jccwz+BMax+IgmCIRY4pci
	re8hVtDJKqkECGM72yIhU2wQIGuHF9u6AZ7dirPMaSo1Keqb/F0Fzkfr9p5gvwe4jHmdXmqDJRQ
	ZZOp5VybuDqexwMqM5xt7BtDijp2NTrW6RSyy8ZB4MF8BHcvN3bgc2dc0RU/0obFI3rkmYbqtqE
	66D6kRk7E
X-Received: by 2002:a05:6402:c4d5:10b0:6b1:d344:c62a with SMTP id 4fb4d7f45d1cf-6b756ae6169mr667065a12.30.1794283046684;
        Mon, 09 Nov 2026 19:57:26 -0800 (PST)
Received: from L9JK9NPFH9.lan ([104.28.20.56])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7579047c9sm548801a12.33.2026.11.09.19.57.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 19:57:25 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Chris J Arges <carges@cloudflare.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	llvm@lists.linux.dev,
	kernel-team@cloudflare.com,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH bpf-next 02/15] net: dpaa, dpaa2: clear the skb core extension flag
Date: Tue, 10 Nov 2026 03:57:00 +0000
Message-ID: <bff7f72c7c28f67497e23a6629b9e4db74332da6.1794281983.git.tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dpaa_run_xdp() and dpaa2_eth_run_xdp() move data_hard_start to the start
of the buffer after the XDP program runs and before XDP_REDIRECT.
xdp_skb_ext() then returns a different address from the one used while
storing the entries. These drivers have not implemented the XDP RX
metadata kfuncs. Hence they now clear the XDP_FLAGS_HAS_SKB_EXT flag
before XDP_REDIRECT, and their redirected frames carry no stored entries.

With the A050385 erratum workaround, dpaa already moves data_hard_start
before the XDP program runs, so the entries remain valid. The flag is
cleared on that path too, to keep the change simple. This can change
when dpaa implements the XDP RX metadata kfuncs.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c   | 2 ++
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index ad2d8256eb8d..4cafc0b84dc9 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2654,6 +2654,8 @@ static u32 dpaa_run_xdp(struct dpaa_priv *priv, struct qm_fd *fd, void *vaddr,
 		/* Allow redirect to use the full headroom */
 		xdp.data_hard_start = vaddr;
 		xdp.frame_sz = DPAA_BP_RAW_SIZE;
+		/* data_hard_start moves, so the stored entries are lost */
+		xdp_buff_clear_skb_ext_flag(&xdp);
 
 		err = xdp_do_redirect(priv->net_dev, &xdp, xdp_prog);
 		if (err) {
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 7227a35dfaf2..fcefdc9daf2b 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -472,6 +472,8 @@ static u32 dpaa2_eth_run_xdp(struct dpaa2_eth_priv *priv,
 		/* Allow redirect use of full headroom */
 		xdp.data_hard_start = vaddr;
 		xdp.frame_sz = DPAA2_ETH_RX_BUF_RAW_SIZE;
+		/* data_hard_start moves, so the stored entries are lost */
+		xdp_buff_clear_skb_ext_flag(&xdp);
 
 		err = xdp_do_redirect(priv->net_dev, &xdp, xdp_prog);
 		if (unlikely(err)) {
-- 
2.56.0

