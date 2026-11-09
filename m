Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253656;
	b=dCm2QOwmHjTXH+eMbPXpwNOtXmrVjeA+VVQbdD62i1v467RkzvEElQ8nnw5iZvUx5o32
	 Wj6lwnu3VqEaTBHLsCDeAsMNU9RJaX1WMrjbZx7Lcsl0jR6ao5Ql9Rv06ywD1wD62wBIZ
	 t7BCQZcJWPnYl6+5/9TINYHLH8sswqgvzLo1Ygdcwua7Dt/KJMYu5/8O07BD8P1r6c0Dj
	 hdfDKyjs6u5CMCp6NdjUHEyQKF7WTqQQa09bCpEcBZwEvgl8wBuDdAbx+vdfLDlqw3oRm
	 b7IOGCQj8iAR2nX7tgxhAP8bb00b+uSr/UzjL0PxFcpInrhMjXH46PKjA2TrIeitQKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=Meo9sbn4x1OKMRTgNLh9692a5YimUpm5Fdk5N0UX5vo=;
	b=TzhqwYyi3qDLY43C5OBTCWRf7phSNNqdLgYggDFXG2uxte4WtFL5zif/Mxq/AtGKcgyL
	 uYYQ4AgYs2+OAhBwlzwKWVdbI0ypGl2iVAOWFCWjqUIzuI0KiaPw1D+Lw6wYQEhwJ38Q1
	 Ij5u0ZGpuUA6C3IWfSTpvt/xkf4wFau6+VAwOzW7zdaONuW3/sblFxZIb5jCiMO5rnJ+7
	 +GCH1QJbTu+OR0NopDfRKk8k3hagvzvL/kkrKPYmq1S8ygkjLgHpSGdd3J4a6AGtTpoZQ
	 yD/r4Gday9OVwzf8j/p1UMfJywsGov1NzD6Z0GLcLQTzBeMuq+jzQGTZ7b7qWDHxTHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zrsUCZp2;
	arc=none smtp.remote-ip=74.125.225.137
Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451AC606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 19:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 451AC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zrsUCZp2
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49e6eb11e9cso5021455e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 11:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253654; x=1794858454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Meo9sbn4x1OKMRTgNLh9692a5YimUpm5Fdk5N0UX5vo=;
        b=zrsUCZp26njJpCeXp85C43RMFintjIW9orSH39mQzw+UDXyUjxuwzO/3zENFxqUnD3
         ub2hzR7GWXr94GAAlc3WrIpY72vBbQpc0aNaC4awHPAn1mTop42F2NI6pruauMadGgXl
         vDbji9mDJHEMyQ8+6fnY5T2o5UHwiDhHxfBlsbn8XxL+Q8RSPJi5adnYTg5t2un66Rwt
         sI/exeUPcrpdezrtFhnBGa6bE5uvV5aOprZzWdE3/AsluiUxoEon/FigtEzcshRPw5aa
         sAI5he5YR9bl45x1Odg/gBMJ83FQwIBf2lzwrlEFk0k9BuWLeHrVyWxnYBWukRz287j1
         VGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253654; x=1794858454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Meo9sbn4x1OKMRTgNLh9692a5YimUpm5Fdk5N0UX5vo=;
        b=mndaYbanS+NPnSUqdlUtfh7PWA6cBKJhx+8WYeWoj9fwB8GzGKaiBMvEGxPdmT00Ot
         PDa5fGLavVVoN6b6lXmziQtcvKWJlsRqaVs6aVRxGF2fLeLwL+0GhVL5dMC0z2f5L8B5
         yx4gqGXQeS/hlFZzcB1Byg4mCOKZLxulWxRH8X84VUuyvuDZVPBDnynGdLB3Z5Rib+nr
         c9cxl0H2MwENmZHfxK+UKAVpQTnIJ7OnFoyY18O797whZDxh6m4UQMFIKKhk2ZbzuJkJ
         IjBvylsY3J/OvPpbnwhFKHRodzsX3zKmDXv9aGSikpvFmswZ10+BgFOkATLASkNduVxo
         taWg==
X-Gm-Message-State: APuU4Z/hdcEyvvCgeW/+X9nYZfJeII/tZwrz4ziWpbgHBUxkeapYul+E
	QkbOcnSVEfEfjNWDpXzrigRitRvNzzbD8jgmmIFgg4BiEPDDi1hV8vrS5kEjSPVD
X-Gm-Gg: AYBFou2ct5jwPAQhxg2EHrpuqHkyQlpBH0W76yGzgk904z0E8fE4pCCBZEQYMmmtKvI
	F6Hg90qXg7C/pcms2UugZhu6kVbE/vb3JIoztFuulRdEnJ0YDFb+MGLPscJy/WVvwDPe0JM3Imr
	F9jPNSSEx+lexWUWoJZWCOx+z/rF4BbUhUTzjBshLHfkOcxcx+xKVEYDS2HmGFfvlud4eNePA1L
	v5vK/3GKO38IGRKxlFjgoou40TqtPaSMs67UxZmlfsBsJPQE2SShJ4gLSRkYWJzkC7i07sF5rwp
	9aoBszYgpqtIbKOIuhMa5fDTDrkhYmGqqbE0d/QM74UAnm5wYScSHq12ibj966AjM2mJIlpqWi7
	piZmoYq95LjNy2HKf1OX6uGvFOW4Q2sL6x//xXL5NsSB4ffY/13JXz4J9VRhAiXh/ajABeMzuP+
	aGsNARI8wVvpdk1OP6hjz9YIztwroFgYZtfZEgGUtBk6bfL5PmavIhfjiLvpxVylKdX0aLFzCRl
	IdQkzvTFdYwH2FcaxEG1BeoRE0b31VxWNIsNzrsqovFddzSCu7+P2+AliDA8jbwsunSg1R/JO0k
	xSead/RmviC28nQBZsA8s9agaBCgFEW1FGoxUrDNFkLd8iNKil77xxFfJcs4kArYU4mPPfUrx/e
	oyljzuWz6fkhaSPhzOVAAkM3UAJbBLT5ld1qbmDsssQePjQOXK7QqWe2PunbiiFn5aLP9w/QxDk
	lSryKR4iHHUc3xww==
X-Received: by 2002:a05:600c:354a:b0:4a7:9006:b176 with SMTP id 5b1f17b1804b1-4ba023363acmr4916005e9.7.1794253654383;
        Mon, 09 Nov 2026 11:47:34 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005762sm10171675e9.2.2026.11.09.11.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:47:33 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/6] Fix ring buffer callback consumption
Date: Mon,  9 Nov 2026 20:47:26 +0100
Message-ID: <cover.1794253561.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=796; i=memxor@gmail.com; h=from:subject:message-id; bh=nscY8NgUHDqmRFgGodbPTd2NqE9asjLsaOe30X/RFQY=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIeuT0q8V4m7epSEXatN42uT//Prdq/DnmeVO/f6Uf5H1i Xu2eul2lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCIdzxj+13gsv37TKn/h9fQt 7g7TGfzfvpFIWrEh+7F+vq96qFUuE8M/LWuGig3zdtz7tLJwkcBfW9GN2ywPpuYEXV31/mSHkcZ rBgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Commandeering some patches from Tamir for libbpf ringbuf callback
consumption fixes. See commit logs for details.

Tamir Duberstein (6):
  libbpf: Honor zero consume bounds
  libbpf: Prevent NULL callback crash
  libbpf: Reject overwrite callback use
  selftests/bpf: Test ring buffer consumption with a zero bound
  selftests/bpf: Test the ring buffer consumer with a NULL sample
    callback
  selftests/bpf: Test that callbacks reject an overwritable ring buffer

 tools/lib/bpf/libbpf.h                        |  12 +-
 tools/lib/bpf/ringbuf.c                       |  50 +++++-
 .../selftests/bpf/prog_tests/ringbuf.c        | 145 ++++++++++++++++++
 3 files changed, 196 insertions(+), 11 deletions(-)


base-commit: bd75869299f1d4ff6e9f45117cce28f8badee1cd
-- 
2.53.0

