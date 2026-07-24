Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56493A960A
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 07:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784878787; cv=none; b=dHisbt+QQX0cNYIzxIef8kixZu0jXLCBAiVOeEqk33fwTrs0YyENfjz9qliGHY8WQoKuP14r4/bOPT66DAvshAPHL1TEb58du5z+jlXa8afxnDNp5A/7L5MpDGjpSlaUR0BatgJhXBLeqF+lDCaKSF6cxJeM2awB3/4WQVaPGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784878787; c=relaxed/simple;
	bh=4EJXClOliuvBiucTM5Xjttqfv0lZIwhh+GMPrSt/fdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lbPyRk+76/i3741zYjXvONeF6IAY8YncwVusm0wTDk/fkTfIugVX3FY/7E7ZxSvYcqBiWTqQ21spwUeMYHrmrF18JTNZXCyXCqrqr6/Rk/7KvFkCUQWIPNjj4eUt4nShYkalXwQ+V5j4regbqltohkmMeMGr4ST/1YMN5RZi6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QyeuHYCr; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QyeuHYCr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/U
	OWNOPUWnFlz+5duQARX8in+ldxos1Hk/HkJhy0jrY=; b=QyeuHYCrBbdt4/+IMs
	o3XoJumEiJSx9WZP6vvMyXtvd6GG8h9kTKmVzb/NGMyt559+mw3Vz1Fkbnqt5ATq
	+/t4oBxYinxAyOmfWlNWCW9n8w24uQibFRKj3Arpov+hqLQbpD4RY79g790SXzoP
	mQPp3DnlTFvfUMtHSOF76/rd0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCnxlelFmNqq6JlLA--.5629S2;
	Fri, 24 Jul 2026 15:39:17 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org,
	sashiko-reviews@lists.linux.dev,
	yangfeng59949@163.com
Subject: Re: [PATCH v3 bpf-next 4/5] selftests/bpf: Use calloc to allocate subtest_states
Date: Fri, 24 Jul 2026 15:39:17 +0800
Message-Id: <20260724073917.703429-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260723092855.0EAB01F00A3A@smtp.kernel.org>
References: <20260723092855.0EAB01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnxlelFmNqq6JlLA--.5629S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUepB-UUUUU
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8gUimmpjFqXP6AAA3S

On Thu, 23 Jul 2026 09:28:47 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Memory leak and NULL pointer dereference in `test__start_subtest_with_desc()` on `realloc()` failure.

The 5th patch has fixed this issue.

> - [High] Protocol errors or worker crashes during log/subtest retrieval cause tests to be falsely reported as successful.
> --

[...]

