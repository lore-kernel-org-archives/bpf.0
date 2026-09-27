Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A052FD1B3
	for <bpf@vger.kernel.org>; Sun, 27 Sep 2026 04:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790484108; cv=none; b=UFoZYjBcfEXnUdUroihRBapPE6GJxkEZGmL2OUukbD42QEjM+u5BaAJ/TINRG7v1zOUo6pwLTxHVBI3vdeeBgjr/EkmUSM+TYCnG7NrOyq/xsCHBGy47XgUn1AoPAXoa2b0N/XkhOeieU6Yz9gvJ/Iux96J7u4wxGsSIGOUQPsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790484108; c=relaxed/simple;
	bh=aSIQliU8fMQFvFPepj6X9dk5tV3aAChq7NCseb3A15w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ivvtpyFG9jxhsGUIrDs+oUpicExpz6fBeBh6lRl4i2I/rZIH79YnlKUHwLeXLU84wRBSLA7n9i4CQmE+2NEqGZ4+df+bleJhFW9l68PMxb4jMcbbpS+QOHse+tCv3z0i683BNRqDdf1M5C6DBJMCB9+Z0+zXXnWC1KWNuwr/Bvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAiu+wus; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAiu+wus"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8692a8568e9so884139b3a.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 21:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790484106; x=1791088906; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aSIQliU8fMQFvFPepj6X9dk5tV3aAChq7NCseb3A15w=;
        b=EAiu+wusG9A/Tb9WV07FSVs9/QOiRuBuLBGZ1VkGsKhGwZCHrYYOeYp3RteNwYJ+2x
         OrW38fpkrNHQkPL3UUCzLi7aSLsJtcX5GtdU41+Ib8+oif30+CWB0r/ARqeWMU/O4usV
         4eTnwWl42QsRVVrYVtnpU0bx6gZnquIKehQtf1Y6QPiQfsGx4zqju5rr3wNDBLZ5JUo3
         ULiijcIWVCfAPMZWeFP9QA6LaF1skgua2++KoXNKf/L8K5l3RDTySZ7qwNuCE8lX2+c1
         pvGF06LvqsqUjNF8tyi91kmAd3agOpdS1VoQhyVKdly79n984HlKtPpEX3tvqW5wRBU4
         XMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790484106; x=1791088906;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aSIQliU8fMQFvFPepj6X9dk5tV3aAChq7NCseb3A15w=;
        b=nnYLaWphpgNB1ZZsIVrtnFTUe0cR1RyHiIoE1/MEn6eRavYOhQqWJSlst57iAFU25i
         q/f/t+usS5xfsuXIgPHJCR02RHns+CSIGhDf+g9l4yNKbdadPeSazB6sNKksBkVINknj
         zfBhwVL3/wyrZWl/MPh72CuzEhokCElA9qA4wMKzZq45ggQRbEITMr2RUs+lqsfNWVjR
         sJDjKOtKhgM8Pv58d41nbT7wfJvM+YYjPx9iZhIZM1m/Y1jrE72LYVFP2GCWViKziv4N
         hj46gDmKFwMGAuLYN5jl/wW4OHz8UF1j9qDSBghTUYIjrjX+9cy+ympGqos9v17geBbE
         FkOg==
X-Forwarded-Encrypted: i=1; AKwUvBwv9wJrzmkq+oc1f/m0FoQJgYzg+qBDGh5K1bvPnxjLTrsYoEBFBAxajZ/L1jpRC0EmLzE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMP4kPZl70hvQyzr2iF2r2SRdWI4jqUNfkOO9iYzDdf9/Euwvj
	0oniGl5f3CaJ0puJ7gb9eUK5FMtnpkNaJgnlLW8l19ceg3R0hwKKTxO/
X-Gm-Gg: AYBFou1lVPndbj2/eFI14IHT2UEIFzF/Tya8CtZXjEeGitX4s48UhHrF7JWKirJdzjM
	9YYyLBHtZo2InSHYp+pAbAM3iRB//P6n300YEpck91wAYrMQEaQuAJ8M0I4FMxSAFFuYVlDjxjd
	GUHqJKxRadhd/hnlHrfqavk4CFxqOCFsQ9ie/jBdF4R4OGoN/wUcHg7XibgHND5P7gtj0M78KON
	zmqysjmUNZc96OEnHvZeypaBX9TMU5ZO6jicsVyTD5uiJjXMFE0BOs2RHdLOkc0cd8KaxRN+fVV
	pjTDhURW/wY80dYOzFL5kibbUrjR/xvDpfn3lbJQZorkGYo4udebnAsoy97QDno/GB3d+QksUiD
	Yx7CV+PFhnFIYxFRBnp9fEppxTuHlq/nGDNYajuubBF5nc+BaT392SPVZcmwLZF85LqlVCKdEmY
	CBBhJN+ITgblX7yxctgtTX4eAv4JQBxbiVRUXwsM4JeaVgCfFxoE/N+1oEmDPgspEsSpUmDPCgH
	/FgV3yhtEQuO/QO/+21UvInBHrWmUJogZnmU2VbhWhqz/H84Dx+9yNGTdj6PoMgeRlw/L/ObSG0
	0pE=
X-Received: by 2002:a17:90b:3d92:b0:3a0:f0a1:b45a with SMTP id 98e67ed59e1d1-3a0f0a1b93amr1697408a91.65.1790484106186;
        Sat, 26 Sep 2026 21:41:46 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9356f48sm13099339a91.6.2026.09.26.21.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 21:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 04:41:41 +0000
Message-Id: <DLPTN52TGGMY.TPWL2GZA38RK@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, <netdev@vger.kernel.org>, "Nick Hudson"
 <nhudson@akamai.com>, "Felix Fietkau" <nbd@openwrt.org>, "Qingfang Deng"
 <dqfext@gmail.com>
Subject: Re: [RFC bpf-next 0/3] bpf: Add PPPoE encap/decap support to
 bpf_skb_adjust_room
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "ThisSeanZhang" <thisseanzhang@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260926210757.2152159-1-thisseanzhang@gmail.com>
In-Reply-To: <20260926210757.2152159-1-thisseanzhang@gmail.com>

On Sat Sep 26, 2026 at 9:07 PM UTC, ThisSeanZhang wrote:
> Hello,
>
> This series adds PPPoE session encapsulation and decapsulation support to
> bpf_skb_adjust_room(), allowing TC BPF programs to update packet data and
> skb metadata consistently.

Why?
Is this a research project on what llm can implement?
It certainly can, but it's not a reason to add new uapi.

pw-bot: cr

