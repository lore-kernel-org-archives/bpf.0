Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2A347DFAB;
	Thu,  6 Aug 2026 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786031446; cv=none; b=ozROPkb+Ka1zPr6fmuy9mnzK0sD2xEh9OYDKzaGAs5TD8MgLvbeol+aE56sR8hqffNw9QuKHBSsPk5EEnvHhKa8YKX5FnFwYe3WuOFU+NJvWDmkKeAdeFIdGdTRH652IJey1mNdQfcbVpDJjzwthhMsV+5WjU70AeB69DcL1H8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786031446; c=relaxed/simple;
	bh=kFO0mgxk6Ju5gVlZ4AIdkHGf4Ed2Q5SX5xKdR/76CQc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/RDDSiVh0JxmoNASwVW6Gfd247YvoW8wUXD3HGKDZ7gIjyPbXGpq70RXUcUmr7WKW4UJCYofddFXiOie3ipBlyEC7cf3Sx1qHNjC2OwqaOG6SG8MUXTmT9uZkcF1QRsxWb4+TqNDOmUIZGxK91bzWF2FtOFErzWuCqR2QV3jcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xrJ2LLxx; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xrJ2LLxx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1786031427;
	bh=XQox8Mdq9VfBsb1IbYDmZGemefa7oruIGZyN6+9QiDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xrJ2LLxxIsKx+ETD3123BP3p6iLSVvRiM9gLEVHBoVtfmn+7+IeAYNr0DsQSaQMNX
	 fSSdjI2la1w9wwKkB+Th99ETHIWoIngnUj/Yw8YMDaQSw3e6d7VAYVfYi0f/1JYdNL
	 KIDKsPTBvEVXomVMjD/4AtqE2W82ROOubH21GROc=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id C4501655; Thu, 06 Aug 2026 23:49:05 +0800
X-QQ-mid: xmsmtpt1786031345tpupl2e1j
Message-ID: <tencent_99A5324B8A534D6F7A68344FD4519715F905@qq.com>
X-QQ-XMAILINFO: MFZ9kh0LMtuH7xRFEwA8Jios3BGybX0iCuypPBq1SwfZKPtUgh9NRh7xpqYkqy
	 4rDIhnUduIho78mnYEuz6I6qZ6NAsB10+35xd2mWsEoGewXZFdihNWJwsM9qBZQOyijE+C33e14b
	 0RTWGqpkVfCsODo0UUGLqLfrwFMo+dLbvyn0FpiWJrPW1ueQALlR0hNpFTuChm/0nnatMsxe9Qik
	 dm03X670M3MzCWs2iwo/tcg/M7fhBUdhHcaNnFGAxjZDFZWcvx39qrtBQ9kPdY5cVUmzYZYt7twA
	 d4bcT922IlRvQxLYBuszZsfJKFKsPhyz343ASeep8j0BziVdBwerXE8dtOl7oYkwU56XqufX4/xQ
	 ncxUVhVfhQgbVXyS8FDpq/kzT0Z79yGshLopr/+D0sRkDYtXfLWrD+ZxjpBMcxF/D24ABJVtunM0
	 xCpj46E1v1jG4ExL74lPgoA5EL/ztLlgvV9Fts+LJMGiOWg0y5Qq2TPpsyeiyvtd1+39JNAZRJPS
	 vm7ecWj97mr1ExiwspqeRCzHH2MLGEbjBwJth0emZveBZ9oqK9BLGD4FbLhcbQmbywTVBSFoMKhz
	 qaLLZXoR5xXJvH0t1AWfTNOVLCsscFmBy0a7ia0Oxd8Vi40e7+NoauvCgqL69f88mMcJ82iYzK8n
	 JTsknxlqiI4UkVRuyKMXYvqP1nvrm5el9KaDymNMshFt2Zq2nSrIhwZeTNPdu5XTFkTc6TGigfyE
	 Vlz+zFLpTcy0rSONE4wTj2GyaidYeOZI2nK3PK7mBAY8wq9tBiC6UY8XJc7e5ZwpYFC8UXqoj41K
	 BL6GeDABXBzBvlgychmr/D0AzHrIMOs/vNB3H7lzbcRA6Kqn6ELdsusZoWOWjAUKxVLkqhBOCzyJ
	 2kMneu1nmfyiU7SX4q2lytJGUo1Br80TUYTXez//gRDQlld8tw6AHRXLU65gpY8ZkAgtNbiPU2Mp
	 s/3arAjerznbC232TbTZRDWzlKZcTk2embGKZZdp3BWbgBwW33XRZprWryI9sdeO6U8+YYBqqYG+
	 WffNyRg3ubRwWb/17dDO6TEw4tUbRQEbJknwk0/6HaOfYdIZBe
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: memxor@gmail.com
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	pulehui@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: roll back stream capacity when allocation fails
Date: Thu,  6 Aug 2026 23:49:00 +0800
X-OQ-MSGID: <20260806154900.1707562-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DKEYMNC99ODB.23WY3OTYMSHYR@gmail.com>
References: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com> <tencent_C919BB32458A4DAD645A68F441345B971E05@qq.com> <DKEYMNC99ODB.23WY3OTYMSHYR@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 03 Aug 2026 04:40:50 +0200 Kumar Kartikeya Dwivedi wrote:
> Sorry about the delay. This particular fix is correct, but I'd prefer if we
> could refactor bpf_stream_release_capacity() to accept length as its second
> parameter and then use it here, to drop dependency on 'elem'. That also better
> mirrors the consume side.
>
> As for other Sashiko concerns, since you will respin, you can append more
> patches to the series.
>
> [...]
>
> pw-bot: cr

Thanks for the review.  I will address the feedback, including the
release_capacity() refactor and the additional issues as follow-up
patches, and send a v3 series shortly.

Thanks,
Jianlin

