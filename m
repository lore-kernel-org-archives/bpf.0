Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488095;
	b=JJ3aPV/U9g8OWB7DlGeSRD/fVVWLKhBNK2K38mW1AIDkVCKLoGQdKPwIHEabPRo4Ox+j
	 Qxb0Rmdcc3u8oKJj3H+HKsYeB5mK87MfXsEEOWnQaYZletJGGDcrJl4H5CADKOoQQptRV
	 HuZLkiDCCojTG/8E+SrPYmtImDtNbFxbj7dfwxFRrSDz9dAV6vSgSPNTUnUoUNQ/F34Xr
	 AispeZw52PpFD9YrFI0/QU6aBCgcKRLExajIpjLwkPsyuZYChMNd8Rl6KhGXC0/wI77SR
	 +Qmr+iC4NZwkoDuiHFS1NMY4KdfH8mC7Gzzsv8kEi68nvEsHjaa0HEgaPldrkHqjeSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488095;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5e+oqors5ngXUuG02qSoQoio2oIJEIQO9xg33zEm4II=;
	b=DLCI8hr1OIacee9kQTdizEtWmglHQdol5JGwqeOIRHgbFWvHEAuKe1UR+uXGtX897kS/
	 jbMwyZSOgR0HMh7laqNN7yU/N2C79MVS22KVYZl44ta1V8JIRLZRGDfcvG8iIvshWYUW7
	 VOw9sw2FvPORNxDQGGE0+5DEU7hiZXpBNaK610XVJvCD2wn0KfK8jd2gRyVFXeUloRl+W
	 P3Ltvgh2dEa+m9H2DauN+dy+03vZqR/m+bDUAxVGtT5GR8lIttpFrE/PRH3gnnuXfUnPv
	 4/dwK518cyNW3j8tNiGcaOanjC0dQ/XIM9STTdN3fp0POR/SA+0G3td0xR16cUbPR8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rbclCkjH;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBF1606A331;
	Tue, 20 Oct 2026 09:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CBF1606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rbclCkjH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=rbclCkjH+HCO6sAi7dtdiLTD6JORM7W7xg5FTdEuflHkpSm/cWeleXuNAwp/bauAxJ5hcHpUUaMjQ
	 kiILRk5ZAQiVJfHLMOtka/m6QN3a4da8MMvI96DMRa+98D10kb6VcRQZ5p1t2ZY3QsnVLcei7KEv+w
	 AfpR23Xz49AALz/Q=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16ad7329b0ac-f75f0;
	Tue, 20 Oct 2026 17:21:31 +0800 (CST)
X-RM-TRANSID:2ee16ad7329b0ac-f75f0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96ad73299558-c826e;
	Tue, 20 Oct 2026 17:21:31 +0800 (CST)
X-RM-TRANSID:2ee96ad73299558-c826e
From: yanxia <yanxia@cmss.chinamobile.com>
To: bot+bpf-ci@kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Cc: yana06070@163.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	martin.lau@kernel.org,
	mason@kernel.org
Subject: Re: [PATCH bpf-next v2] tools/bpf: Remove legacy BPF tools
Date: Tue, 20 Oct 2026 17:21:19 +0800
Message-ID: <20261020092119.918464-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a02301c0ff8593349602f81cdf0c21f1b38db0b60118f8eed3199a6a38330234@mail.kernel.org>
References: <20261020083713.905006-1-yanxia@cmss.chinamobile.com> <a02301c0ff8593349602f81cdf0c21f1b38db0b60118f8eed3199a6a38330234@mail.kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Thanks for the review. Agreed: the table lists mnemonics, addressing
modes and descriptions. I'll fix the wording in the next revision:

  The instruction set consists of load, store, branch, alu, miscellaneous
  and return instructions. This table lists the assembly notation and what
  the corresponding opcodes defined in linux/filter.h do:

Best regards,
yanxia


