Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422930F7FB
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 06:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295752; cv=none; b=KJ4OuHgCmMWkbu/60Ml2JkmZsrFXMkFbB5Mrao9gw4hj2+GDFsQpP03vOpI3LwmQRj3Gy8yi65pM+zIRzBNoLtb9xqtPu5se2GJHZ/M1ALGHYufdAOeN3TZSEcT3sW5yJhWJhSuDpHV+eqDPfYg/2t6Lba+dEDtl6brc50L9Shc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295752; c=relaxed/simple;
	bh=mSrf/R2wyHFDHEO472ySgeqp9iRKsHdlQgrj43CETto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IuUZaJIdBPwOhxJ35n8LhvhgYJgv8c+F1JOglq/YC72kOjL34ECge0HI+XJmX5I7gK4ytyhPsKyeRLgKf22o3GIWu1eypyYVgDeD7I17apiP9I8D/338gNW1XRSUhXLdZodd5JR7ldNis0w7JOvN9NwPasYd3BDmeupPfC57XaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GNHNvhoM; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GNHNvhoM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780295665;
	bh=Pa6uM69zAhT8Ksi94xXsM/bpX6DRtWUW4iiySLcqwrQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=GNHNvhoMTwyT6OXOphS6g5SVtD3gE4A2AjYgRgvNdZpMaGU9VpnRaNmeu6XMf/nPo
	 L226yPLytceKgTwSEBc6rwFqQLVeZQJto3d41MOhm7df0WKu6ZBcDV4Y//pTqzqzoP
	 y2ZiLhGEm84USQgu8eGz514bavmpRn5gkj5era8k=
X-QQ-mid: esmtpsz17t1780295650tb6ae4d84
X-QQ-Originating-IP: /Er2uKdRF2ClQCcCIflW8DJzaoIWDrcea6D7ndD6tHM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Jun 2026 14:33:49 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5380624521232554661
EX-QQ-RecipientCnt: 17
From: Shijia Hu <hushijia1@uniontech.com>
To: alexei.starovoitov@gmail.com
Cc: 2022090917019@std.uestc.edu.cn,
	M202472210@hust.edu.cn,
	akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	david@kernel.org,
	dddddd@hust.edu.cn,
	hushijia1@uniontech.com,
	kees@kernel.org,
	kernel@uniontech.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	paul@paul-moore.com
Subject: Re: [PATCH] fork: Ensure copy_process() returns a valid error pointer on failure
Date: Mon,  1 Jun 2026 14:33:49 +0800
Message-Id: <20260601063349.2524658-1-hushijia1@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAADnVQ+=-UM-JC4eM=vqvgK2tLt6PwmDjOcrrDG9kz8BV6n49Q@mail.gmail.com>
References: <CAADnVQ+=-UM-JC4eM=vqvgK2tLt6PwmDjOcrrDG9kz8BV6n49Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MFE5XDBetPujKvZRqxZlA6dg3H3txvekj7Fubp2pqoncPSfvH6pjRTZ5
	TQTIvwh/kWrbcpeLPVD0mLzICL5QmjWTf81YaL90qCuuDtInJr3ripBwNApkFTqzyCkGsNd
	H+AwbibK4QVPUZ1539ob+xVHPW3EjaBGeYm7QlFhYlO3/MdS0SQvihsQ7V0EvaQLiCkmpWZ
	p8vEzJeY2N46tmyjl0zZLEPfQBayn69+pRBx/RARbNjS+E7r0/m3zFu8StHNzh2jEbaH4DW
	3gsH86I+kRV0i+rEqoGmEg38a+jT68RdSuowe+VRhh6on/iwGT6iw+obsYEq7Qqvv40+elP
	wJI9mdKi8Ps5Q9XrFmh4zeBL2HVkdOSMZEDX9cydMUDzu/fYsO9CF4Uwp/taozptmUHK93V
	4XyRGQyuRU7xMcFHEV5Gx06oMQBuvlukWvNVEYGRqUsYhgP1A/86Ta3IEqdBDlxVjCfaWUQ
	uUfwE7/ROFe0mLdyTL3mNicHZZ0RDxKr5oa+NOevuzxEP7W29GqqdKdSBpIxNDGtL9+fPeI
	22ReihnPOIhHHgovE1CfGaKP4rS6zFP1urT1Hg77DpcgTh1Gtxbkz3GdUUv3SXtL5qORhYS
	vcDgL9405qi0XGzVhw5veaH3OfvbW7aa/Kd8vFyPwQAWQ512+bWJQO0WISFTNv42+WfH3Nx
	RhiZN5fM8eY7NJllnWeX+eMa2cCW4eIWVDggJorfcN/yGSSvsp8NbQ5819A8+W3Lfaj+i2I
	WphJeVW4lmsJS/n/zSbfxvB7K8nNJ0A+Nj6ysEnuuPAmsYCSDS15fzB0r38OYNvz24GVMUk
	40j7dDzSSzMEUdqBc1Ir+m0p1TF5dF96VaDG8NA6hzDrGTHmU1jXxZraA7e1ro0YLXuENwu
	E5OTLmS+cq27GTlDKZlG/4BtcU7w7uspNCpKu51c0c74qyM2hz1jX2iBjCOzuvPZ8l4uyjg
	2CO7d/vGeP16ResLlyTej4JFfZBTBQrogBOqr7YNGZeLColBsw0dlXz/4oJz4N7/1ewqQD9
	CV5dnz7sEkds5K/x+HcIOEJI4BrmwHd1aJy3RvJz8Z0YYwfoD9EOMSK4Rws53ML4CGBX4vt
	ZcTS8wFriwtVKRDiumH/EcCedlVTb+Jkw==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

On Sun, 31 May 2026 20:58:49 -0700, Alexei Starovoitov wrote:
> This was reported earlier and there is a fix in the works.
> This approach is incorrect.
> You have to fix the root cause, not the symptom.
>
> pw-bot: cr

Thanks for taking a look.

I'll drop this copy_process() approach for upstream.
 
Is the follow-up fix still being tracked in this thread?

  https://lore.kernel.org/all/20260411163556.8567-1-yangfeng59949@163.com/

If so, I can follow the progress there and help test the fix with the
security_* fmod_ret reproducer once it is available.

Thanks,
Shijia
