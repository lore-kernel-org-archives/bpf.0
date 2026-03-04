Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96030ACF0
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587623; cv=pass; b=o837vFP8dck6ZwK0qNnHz8i+n8oThialnxINRbjhsjlvUaRDh4VO+DNfdxt6pqM8SFPRuXi66gX0K7nt0S00HgVT2XctY+jC8+BFBmPEQFjVK4KupRvuFQ3enWsrRvGT12bp4Eq0Ai8QiqtOTIJU8NOSV87GW/u9SOkdgAJgAbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587623; c=relaxed/simple;
	bh=FHYjBXW8HV0h+QKFk4VqiWMpMzLMEpCxoDWHLBPHxHk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hpE9AzFp81gm0FDZUfdXjU4Htztt99JKyvoy7BxDftNnMWdrHSlQFxaUueC0u4cszAqjFDcxI1a3UxKMNjL3HBjnRHrq4nT/n4xSxzdSmdiRpU7snP6pm8zHRRQmRV8qms5mirfIR1tS8kIpZ0oePPrIbwlGohPTTB2MW3HvZaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXxNyIWW; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXxNyIWW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48372efa020so55166445e9.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 17:27:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772587620; cv=none;
        d=google.com; s=arc-20240605;
        b=gnDZeXuU9TCGkboz1n9DgmIZTXxP95UGBWxAGJYrHzUHU3GekwjK8PRBe/Hu6m6r1e
         /RbnViTTyVxGTA+h+q3rR67QmCAOw+mB48+ZCOD9/Nl4qPcUwzUalAFim+qm2657tn53
         sx23vNsvU20mF+5aoUOuSUB3EaZHXlp6CgCnP9HFGBUeJeeXdkEKT3G6V1yboVlrs1q/
         pr3aeVfpATlSD1CNLJ9oAsTXNBENWVSwfeNw9BIvyUMhjSgkORiaE4YqJFOrPh6mFHBQ
         9JTBfGTMExnzkIrdTVhFQ0ZP9gvdQ6MXkYd6c3gwPLICVX8YFQ66zikaDVzg+YvIZRdU
         R74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FHYjBXW8HV0h+QKFk4VqiWMpMzLMEpCxoDWHLBPHxHk=;
        fh=R+oH7rToOi4uBtfAhwdLwBuw7/zOR4LOd7duA2DxMds=;
        b=g4qKmjWGEjXStmYlKAvhHKBLzQna+eomApLoiTa4CKDSZHDH0KAlvkChsfhmV2Yv4L
         MPw6q6ZH3MvfxN/N7CTzS3Lj2YIr0wE4OPmJCuIZRz6QNHAOAOaAzRBTaD6TicI9Rqv0
         jbb2BDBFHUebzhF2phO6ovNmVhmjckrgVuFgPqqLyNVEWFfAzqWJeqndHa2plGwrYQgZ
         J4yJQwUob4gJQ92d2aUFAX9ypqB8EYeUabINjtwaZj2PjBvW35J2Ac/ybRc5uDB/7Xps
         lOSw35hH1oWMvEsWICycht9pcdxQDdKz6iEiQgI2OezlFcZzrw+8w/32Sgh9XNNOtXiA
         lbMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772587620; x=1773192420; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FHYjBXW8HV0h+QKFk4VqiWMpMzLMEpCxoDWHLBPHxHk=;
        b=BXxNyIWWOu7MWoE3ssJqNi32cGoOc9MNVM3pDAyybVwHUfpdsxrf39VUsZ7GpczyT5
         dkWqhEblOSm6dwXWx2XzPV1LLtlGF8Ne6k4wVHDDY6g3EKGX48mC2oUJrOk08AkIsll3
         VtGX8Sw4mcBymazUbFpXic4PlXUJC8XkFEtTuH87QzynZzlGMCK8JfxdFjveqhX8gzVr
         XjqJLRxDZtT2hvuOOtcSY6atvA45YgzG5ABXfue0l2iAGiGW83wx+uyaN8gCcLqEv0v1
         cdZYga9nmhfC0CSJ5G1gw+fCXHWbDc5s6l+P9hAwJiQijJlO+MCQ/iHNiN4GVPLgFpLT
         BRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772587620; x=1773192420;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHYjBXW8HV0h+QKFk4VqiWMpMzLMEpCxoDWHLBPHxHk=;
        b=pBZytiwJ9nA3VlgFk5etyRo19EWPnxdDXcH0IdHPqDpI5FlxN6oRNLQkj2upV/LMF8
         4SwGVrxTynZ2s6emY/1jGYGsCMc28OBynVOnWiq0d/sVKfMYj04ea8AaSD1lR2hMXJdd
         qpIxj5oPCUiorCyP3AMPCktUpklIogrX6ScjUQ/HGcwNCHxnjG50T51aJG+a7xO3mtce
         wo3T/oU2kIiiD/hLbYtutKmwIRtpPFFQuvEYyUZzapbs+zBTIy2AKWSonp1Mng2WlP2E
         1VElaiXERbANcl0qh4n2vbPzWKOrIWJMATXzngSnc7cIDhm4xn51JLSx0RwuaEN5wa1o
         NBdg==
X-Gm-Message-State: AOJu0Yy8wUtfmY9qtS3s4Jxwxn4i3smI/BlXHdFSBv+i+J1RJFNbk1Ls
	i8tB+B62M2R5I2pyrxCyRHOojihDB3WEqm9MVDDL6pM/7yYAXc/iIldFnBToEdG7aZp/eWZFHl4
	+KqWSl7dI7NcWtkVRaFJpUSFdlEgSN5x+k+oV
X-Gm-Gg: ATEYQzxK0CMoiN+iVmRlGw0X+xvD68qdFlXs/YiHm3K7LjXTqkTUYvIoGt5NgvrcJid
	GHMV8x2O91NCy27PCkFyDbK/hwBcn63pFpblfyi53X3/Mo1Xb5zpHwgVg3MkiA9rRCQWv+MDRrg
	zkWh38ZLJLSCmmHWNgjOHMbVJh9zkj+vGCimmokOjj/DIcosShfQWFb+nd163/f4Oe1Mt3znszY
	0hsalwQBS3mnKEOh+lAo8L/f2siu+W0+52abhAyjG7zER0CoGo4ELbQOiybG9yu3lv0eqn6PYbf
	9KpGgsxPnLVs9Ixkx5UpO/wvCUtNeJmg5YoaU+lANipmoEAatJw0I3uuYm3T8osFCbHEX8ppGjR
	EmOmW8AqSEp+HGyJg2gwWBSnLBA==
X-Received: by 2002:a05:600c:34d1:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-48519888c4amr3891405e9.22.1772587619950; Tue, 03 Mar 2026
 17:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Mar 2026 17:26:48 -0800
X-Gm-Features: AaiRm52eilpTo4fMDeSQV13zlFfC5zc5JC4tBK11mYny_DwuguTFg-zz2_v2X8o
Message-ID: <CAADnVQ+TKKptnNB25V3=bcdybh5G6c2DyW2sYtXvyRaVnPN8MA@mail.gmail.com>
Subject: Introducing Code Review Credit System
To: bpf <bpf@vger.kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Hou Tao <houtao1@huawei.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	KaFai Wan <kafai.wan@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, 
	Luis Gerhorst <luis.gerhorst@fau.de>, Menglong Dong <menglong8.dong@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Peilin Ye <yepeilin@google.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Tao Chen <chen.dylane@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Geliang Tang <geliang@kernel.org>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Jordan Rife <jrife@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Pu Lehui <pulehui@huawei.com>, 
	Saket Kumar Bhaskar <skb99@linux.ibm.com>, Song Liu <song@kernel.org>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Tushar Vyavahare <tushar.vyavahare@intel.com>
Content-Type: text/plain; charset="UTF-8"

All,

While coding agents are significantly reducing the cost
of code creation, human expertise remains crucial for
maintaining code quality through thorough reviews.
Although our BPF CI AI bot provides an effective
initial filter for many bugs, the sheer volume of
submissions continues to challenge BPF maintainers.

To ensure timely and high-quality integration of patches,
we are implementing a system that encourages broad
developer participation in the code review process.

As a prerequisite for merging a patch, the submitting
developer is expected to complete a comprehensive review
of another developer's patch of comparable scope and complexity.

Code review participation is an expectation for regular developers.
This requirement does not apply to occasional, or "drive-by," contributors.
