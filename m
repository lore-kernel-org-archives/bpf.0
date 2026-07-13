Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6944E56A
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 01:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783906282; cv=none; b=sRmgLRcL7cPUJlupLcgC3SLjvvXRKnpVu9p/UFJ/17FCAJs93je1i6NfYkaEXphzNBfhAc7QmsIoj+1TSboQpAjy8Ia4u94UCozRRhT7LUERk2R+mZSIvTb6e1qELRLoS0h7OOnBF+yY3h0W3z0zhCEirajLzBohO2cOaUZ4jE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783906282; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=DOENIdA9OcyunYhMCqPP+sq8Lw5XyfXbc4wq0GNv6BB/03/CTzggAHc2n9T24u3gKgb/+auXyRa4RAkeYR22HJq+p0lCJI4A1RyPINpIibOUZro0+sFjZxOs6c0FNZcwenwfa6cG49Zn1jQx+0tgAmYbcHy6CHb78eYoyODSy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=osiKoNRc; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="osiKoNRc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1783906269;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=osiKoNRcDUMtpCgqqN5NPj+eY/sBpXsoeZMUWjWGZScu70oBrWprnnixAN+8TVDxi
	 IuaxJ69UHzLHLtC3Y+n8FNe/CBpNvSCI//OknmP8oZMRf3a5dCP22m6P1nA6k50G0A
	 y8RzyOBKDciEi6jlPNRnA9auvtEzmDjZPbO0j2vA=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 7C7B72BE; Mon, 13 Jul 2026 09:31:07 +0800
X-QQ-mid: xmsmtpt1783906267tvqqvz89f
Message-ID: <tencent_3C1483DACD74E0E89BE888AE193273258C06@qq.com>
X-QQ-XMAILINFO: N7qqMxIPUfzlzTNKKnVCNChqqRbZlom0xnt5Ny+Y7XcZbXgMl5SVCHEgtifO/N
	 w+SwyFHdxdCpg062Y6IGam+NfFZMOod8/lAg1Q+TNjKK9poSfdpJBE4Xsv4FS/zsBu7lAH+6kizS
	 70R0J4+pr1WgzUQuJwWBF1WWbeueMYsNymeZS0FDDUXoOAwEzArqXcR9sILJJYHWO4V9yYLVrbd/
	 nrLdK17nK7KFvrfFDDE6ehLGetL+xlWpKn7g1K9m8mKrNx0YmummR08oGejdSJ0EVlby1L4vwml2
	 okqmUcRCmNW+O+QLy7od97yWPOm3uovaBGrff78aS3060borqVvHvfNpIR/4keCm+tJKQjurXdwY
	 hznVsJRPp/Vxw8hT4bkjjS/FmpMdB2rGkOrj2nQsbStJN/HLP+gqsMj78pnc+X/9zDqJeHBBkimD
	 ZK0WWOVBdOAqR9TejlPqKMPJAn8v8A9u+81iD6YDq5huDx5i9YF/+DIzX4T9Dpoag23yylslLK0i
	 J3cMvi5jEatSYHPwgeN1qJjPCxZzfkVkaHNTFe3H7U9RJWLblI/yix381bicjTcSaViFXJ3xiS9e
	 +Z+tYEJMwcABY0nQE20PKouZ7zRAQoh5rVpAPD2l9LXAGyfQ1FmX4fkJceuWosUPDiEApitsv+go
	 Tgh3CIgdWR/MN2pYJUeey+6Ab4LCThDovQyvsgczPZTZ5zSjgZLSBvZRYOY5sxuYqfGAzHn+L5ke
	 2stxaeNiL85FyWsBVcf8fiw/2oNzST3muXpqB7V7t/q8dmHYTvxHf6L4Rqzf6NMicK6klV9faqGl
	 HVFO0XsEcsaDchkTJow+K83z7/WQZMF2uJ3Hx9zHTcwNNLz2sZ3khyZGO/sfyO7/1mDzA3u6/Ax5
	 v+0NQoIIFVd89fStpHvVz0RL9TI0bWqQRxQnW60zI1n/kVrijnlerDSVtVDNi1d6fXk+jMsgOvHh
	 1kD2p5L3PYjk637dbtJTqGWy+HpOlyO2z4oxbM1Z87bdaTMQJt4UkBKByX1juA
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Subject: Re: [PATCH] bpf: return -EINVAL from bpf_ringbuf_query for unknown flags
Date: Mon, 13 Jul 2026 09:31:07 +0800
X-OQ-MSGID: <20260713013107.1721142-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710035555.3725522-1-shijianlin11@foxmail.com>
References: <20260710035555.3725522-1-shijianlin11@foxmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


