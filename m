Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792464490;
	b=gEa3Wo0IAnVaNOHH7/Cq6q7++1LhitmN5zexkq8K2ZNJTxaiDYgE/WDwGy2PCUiXHh6Z
	 bmQ6XktA0su9YLIVApUr4C2Jv/On5d+luJig4KMz055QkFdAW9kGUJbrtv/3SbC9lrrlA
	 oZSBQtOI/zvEoAuuncy4d3NlldFBKdOlSz/lGbOjJahupOXrWxp+tCOQVpHPmwcxnGaDj
	 i6Y0hIVKrZy/jmYFSDrCsfRGJL46UGdTueK56vbxh6i9L0xZXEdXoyiMRLKQzcFwNHi+S
	 9AGB/sNEsZRhGJrBdeCeWGa/5us9R0tTIgihhIfO5u9GUedWHYcx81iRmMJFJ2Vjsew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792464490;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pZf889O1BH2rY4LkREd+HV6PyzoAUtJRe6KFo3MqDHk=;
	b=Tz/+EUz6IclBc5Lfk42eGqhpuwYvqmDvau+5sG3Tj0Ly6vhLdtbMpshxnJ/OFwpJKtFB
	 3GzyyWaAiRnK5Vl5Goo3myN5Jh+cuJ9gRRr+d6ZnCWF8l6qztLtLU0IyyEDwEDDplTCIR
	 wXBc+nKdQSO/FGorsp6ZbEm4QTPfgwMaocMn1/PTn1ZkPnTrNP8TnBwt4H1yPeEQZw4TV
	 Ia4uxaeyi6naU8kEU7xaAf1+XBQnnvFBrSqbtX31RFR9kxMDPjqjXpVXh0KAxUjAYxw+q
	 DwUw1OeUZo2i68xb3ee9ZmoiDswTqhqvsvqC7z/qMLYzM1WjNCM+vtaKtgnjGahBenw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=TP+OzqTN;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F58F606A31B;
	Tue, 20 Oct 2026 02:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F58F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=TP+OzqTN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=TP+OzqTNNmzvVrSMFNWnWVB/qn5HKwcl7wBRxa35o0E5RKQT0ioJi7RkmDpiLHxBOgjPo/hmlZXdm
	 AI1Iypb1OV4g3vomNbYjhrLixGVmcXTuH1mLMxmBmIy+XYNTpIHzgiw/erPRcXOEbLFjmPW6TWAX8j
	 UHPOBvQy7NgYHlAU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46ad6d65fbb7-b6aab;
	Tue, 20 Oct 2026 10:47:59 +0800 (CST)
X-RM-TRANSID:2ee46ad6d65fbb7-b6aab
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56ad6d65e842-bc558;
	Tue, 20 Oct 2026 10:47:59 +0800 (CST)
X-RM-TRANSID:2ee56ad6d65e842-bc558
From: yanxia <yanxia@cmss.chinamobile.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	bpf@vger.kernel.org
Cc: yanxia <yanxia@cmss.chinamobile.com>,
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Fix packet length loads into X in bpf_dbg
Date: Tue, 20 Oct 2026 10:47:48 +0800
Message-ID: <20261020024748.804785-1-yanxia@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <61f7315e-c835-425e-a99b-d2470ba9a875@iogearbox.net>
References: <20261015135702.352284-1-yanxia@cmss.chinamobile.com> <61f7315e-c835-425e-a99b-d2470ba9a875@iogearbox.net>
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

Hi Daniel,

Thanks for the suggestion, and sorry for the delayed reply.

I'll prepare the removal of these legacy tools, including the build and
documentation references, and send an updated patch after validation.

Best regards,
yanxia


