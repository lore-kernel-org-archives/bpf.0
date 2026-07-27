Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F16244661;
	Mon, 27 Jul 2026 03:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785123620; cv=none; b=j5vDU+IlDz5IZfFLJ3jPS2yBWdZbTZvqrsi2CK25NJL7q3GA3jPN5VKqzuFBxw447dwWoBV+3maQt1790pzBQ2IVj4OCyL1Sd40P4bAwKOxx1/HE8wrPTpD7Ik9IjujIRdmQU5qLdNrjPqg7JyPdTL6IX3mAekTTz/KV2Zdd8Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785123620; c=relaxed/simple;
	bh=ICM463JqSJBVlMqK7po1gLkpAcxO6GvDKB03qJCUcaE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSrd1dsXa+W7yI26S1ilN0faGJ7YtX5KHopDQtpAf3vnvoL71LQvmUzfE6LDP5vB//OF8MlliQANaT3Rx/KW+pinaxIfDarht1RrMfkCYC1Lwspfpzv4jYlRcgAsCmNVPNIyYWUqqOHwWVuKMJl8vOG4mlWikqRcR6rqkbG69Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=dOKRtYcG; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="dOKRtYcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785123607;
	bh=ICM463JqSJBVlMqK7po1gLkpAcxO6GvDKB03qJCUcaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dOKRtYcGjWY11SflBpKVt6DaT5y197j9C5QvXFcunqw2+QBrxpWDTp3zeVG4A0QOE
	 ua9We9yDezbfzKE0b+Oi+ErHnAOBpLR2ps650oja0uZzJJmMxlHi0NylU5wqATEn7m
	 3QD6gXC6fdPB07+UyjUZes6ElGhKxZyL51AgFoDs=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id A053540C; Mon, 27 Jul 2026 11:40:05 +0800
X-QQ-mid: xmsmtpt1785123605tb3zop7wl
Message-ID: <tencent_CA12957F520C6A04D32CA33FA28ABAA3C808@qq.com>
X-QQ-XMAILINFO: NibnO81X6Pb5cAbTknctAQDPfPbJsPagSzPJ1j3B7ogG6vhD97KuJZWQQ7IGgr
	 eNhZ1lmQhQDySsKwrvkUz6nbIWQ9sSYHQN9Zo2tOBduDW8zFqOAMaEk1HWkBhPREfuRZBgeLSk3W
	 BrgVpTurunlXO5WHqctZQJrHLo1HBCYIS8Wrwa0xwj3WMhyq6V2CZa2QeaFAfLMiE7LTFIPCNCta
	 GTGGLVzgl26xps3mGIROy2G3PODbYAVJ1XNXfOtUYBJ30sboY30KlFlqjCEjZ6O3a/FH2f+mBdjt
	 eX2SKzZXTv8IpmukYeodNRyvsJJlOo+VsFlwDSif2eQk+F+AhpThjHDGlm4sCJbjc8NZOVI8fTwx
	 V3YqS+6Kqw+7Q1PQf509X1qsrVGozbmCRnKDhfNBViZNeCLTHOZX16cNe56VJpC2gpl6PdoB31M0
	 /ddN/9Z1zSMWjZjMaQkNxYD8IH9NLOa8OfDs0fFdJP+N+T/zimQRC21I+d+68iWKYai0fcMQC3c9
	 Ud5YzO+dqW8eLbMWe0a+tJNMbptnyUJckxYv5S6+rMMAvhTuwxpJIdXOzzBH9IXs4b1W6FdNdEGe
	 QTvnqVqrAgA9tY6K6l3dAM+k7ULKC3NMp1b/PxrEvj67zF76X0Wh6FRrT3CVth3inv4O0iOl8qUO
	 /1D9zPPSJipG9VHD+MjuiZh+8Pd8OARg5WNRKogERSgPKHbky8BYjw5tKu1eY2ZbpcEayJ2YTpe9
	 DzBW6A2zSghfvc7K5HS6s3SnvtK2OpMUX494PKqnnIjVQwohjnsGRITrjARZI4itVm150aRtYSop
	 fvxOL8yF7FWuhHomP192E9VRmt6nCFMyDXUo7l2xD6zWAZn/VKts8ThUNTXx/o/DOqUKXSp9XnQu
	 uOAb1egzw5q/Zjr/9/940Esm3K4m4l8a1ObXk3njKPj+jwwbtG78ZUgGJFx+ESI9e6pZff6fqPYx
	 IFxdxb8X+vFfk/9tKfgB5freNNjQkQL48mWRtDmEO0PFqCiACxCa3gq9OBj8jA1+FclM2GQGkazF
	 dDK5/ASA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	pulehui@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: roll back stream capacity when allocation fails
Date: Mon, 27 Jul 2026 11:40:03 +0800
X-OQ-MSGID: <20260727034004.1111719-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
References: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com> <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Friendly ping on v2.

Regarding the related capacity leak in bpf_stream_stage_printk(),
I can send that as a separate follow-up once this patch is settled.

Thanks,
Jianlin

