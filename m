Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556595;
	b=r+JgeJUBJo+DF2jln5w1x1N60AM4CBnO9FybWrTUhLiGDSNeK0VcucZxRhjofLDwtAtv
	 SyRt5CXgMLGXmwzl7Gm+LuWXuVpOt7tfPinAxjqqtACY4kN29tJyS1O9VpDHyqn1TNxpg
	 AvtqenvXg5shic4Q3ByOszIYsw9wjyHD63Zq2Agow6IfAZK09IV4u3DX3iwfKPmVlyhaA
	 iaqG8c1Wzt8bspH3mVl05SUtsCekUhddHTJW2zoM5fjn7pCFVsqJDndpME/8eRCc/wzcF
	 uRPe4ssyYZ5duseIoPyL8aP9CPEx/YflAjNXK4HOuJMVB1VB8BqAbSB2MbqokADcqfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1dgevjOWuJAYh7LIS5HDx0mssJ5LCiALLAiYYaKE9M4=;
	b=M0IQsT2Win8ZCCZp/eiG6hz+dK4JbcEXqA3ER4jLZmGf8LXVIl2R5ABS4rr1H6popITj
	 hQXFhnShqNYAEFrgq1HCH8gwdZb3Cc51xijfU72LMldQIgvBlw4jjnb2gikpKB3scpVoo
	 ezWKP6+Tsa1WWHB5PNgc078PgqNc1g9fD7RIzkVvur2hT6WdUfjBJ79fXV2Iy2yYL2OsH
	 uYl5PnZ5AM59mPAWozcLY1GZLJnyKbpzZpWUz6D6xUu/IjK3XvQ4L7mBI+oyhnlTFrpoJ
	 bTotKccDz0FI5t4hlB+vxPSxkSzPlQv8VhrQuqoa7ADyp3+Ds1LxEmUfmq7tkE6uZiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0LgHWBrb;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DBF606A31E
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 21:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62DBF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0LgHWBrb
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48ff6bd58b8so472893f8f.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556594; x=1796161394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1dgevjOWuJAYh7LIS5HDx0mssJ5LCiALLAiYYaKE9M4=;
        b=0LgHWBrbm09GnvzktQXlq+YoVhTra+a8APFk5vqOolCQeExJ2faUuCcI9hv+G/9vCv
         Y67rTSPHFaLPgYL80KJv2kRu48ClOL7d+Pguh3uoSPikRzMiRgMmwMYXC35wXS9K486r
         VxHTpTW5Q7cqFI6ZBAqWwec1Rt4r5FgfiLu6EI0euirfCHVplEa4awaH+j9cesVX6RRk
         UJJg18yWHb0hp9bSHAWODvxczxKVMBykGIdWtrgK1bvLKecrE4Yd01mpNRSp3MjWSY3p
         mDNbqM3QgFP2ND0EuUIcaDnK5m0rdjhwBYfdGOzk3ifogWrpN83n5RZZMDEDu6dRiRLy
         z3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556594; x=1796161394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1dgevjOWuJAYh7LIS5HDx0mssJ5LCiALLAiYYaKE9M4=;
        b=qzyYs5gC+p0zH2UhH9mZPYtEqTSne0ZKWYP/8d1g50zQ+VLREUvqMAwiY8NvT4rn84
         oeuUTwST9kuo84Uw7qDX+1KAV4XgDw5+Sr81W2H1PyLGIzOliD2wOQdK8vxUBNv5GUkd
         EjwvI8noJSl/I+mVat43Duq1SqNB60D/njfWz8ekriRxNFqjzTg76TrnFZ8HuivAPArO
         ywHu4auctf+hCtr7iWwgB9HAtBWVzQJdfKMQRGYkr1FB/Xalc4YjE05ieeNKqzd2XAv8
         i04wwk7nkzy+0foST1MQx9BNfLeWsJzlwQoirC6jgiP4D8/YVZd1Wrvi3YdoLzpaob45
         I/1g==
X-Forwarded-Encrypted: i=1; AL+hErHrn7i0CA7fymjHjUmX9p94LUrqT7WrwaIiTVrRb6EjLpdENuJJetf/7Myt1pc9/qc9GiE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hLtR+Zg0qCP3c+ueUvorHWcxIzIGVl4a0s6GrLMTZZlsMnYZ0
	G9yznZtAvGSF/aa3d5tKZGQ3J7YyJnJ3wqHikczf4HpLlumV/lnWx0Yp
X-Gm-Gg: AZFdTZd6eL04W8DxghOT7TDSpskEjOy3jDNHap3yCXy4APE5zSz+7dhJwviXb+oF5b8
	Ro5xavIecAWmFL8lRiqAQkwg3wiFILTI8P/MPmezR7WMu17zPo2791ty2hI2lgI20AnzdEoAJbP
	cVT5UmhP7SducVkh/r4Heq44pKdXFiSsl2wvRZ+IK2ThWeS6NTfyoIyaHbWFow+UBDozi5/AZam
	Kg1dHitneAQ3fyVURFW9XWtRVojB4Ro6UFzd1ylvZ9VkAOD3Q3sT9iB6b1EFk8O0bmWvU3EcbMz
	uDVTOi7Z2fluS9dBD9tHdxmke/jWfyCjCcfbZRLF4Oj1BinTDAXieem1I85CY281TlggS3C3OZD
	lrrkgXoaAQ/v8Df/1iylOs96Go466ArXKV+1kIkJkn7NBxm4d2fEAAmrP9jFeleD7cpRnCL9rfc
	BYUGghcFKZhVXg1g0GGPu4sgsBXIGktrQ/S9wFyIernY0Mnl6Fu1JefjNk3ASI9XZBOr/2wFJ7j
	Cprj6LzPeoyPVDgwMNe29/qrwNV6HkO8eqvQN6uBDC0bWQxVwTtQ0/hVd0l1ye3FNNmAshLUYvM
	Lo1DdaUzCA7Z0kPfaxs1IXjwyXARRC3cfLPXR9ZeD2CsFF+GXp6M9rWPCBCUi1OxClp5
X-Received: by 2002:a05:600c:8284:b0:4bb:6c01:de9c with SMTP id 5b1f17b1804b1-4bb887f55c1mr283837645e9.2.1795556593828;
        Tue, 24 Nov 2026 13:43:13 -0800 (PST)
Received: from Nuel20.localdomain ([105.118.4.83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906640a2sm244195265e9.0.2026.11.24.13.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:43:13 -0800 (PST)
From: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>
To: tianyi@cloudflare.com,
	hangbin.liu@linux.dev
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	emmaonana18@gmail.com
Subject: Re: [PATCH net-next v5 3/3] selftests: net: veth: propagate bad-settings check failures to exit status
Date: Tue, 24 Nov 2026 22:42:55 +0100
Message-ID: <20261124214255.12280-1-emmaonana18@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123140946.13992-2-tianyi@cloudflare.com>
References: <20261123140946.13992-2-tianyi@cloudflare.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Nov 2026 14:09:47 +0000 Tianyi Gao wrote:
> If you squash this patch with patch 2, feel free to keep my tag on
> the result.

Done in v7 https://lore.kernel.org/all/20261124214025.11603-1-emmaonana18@gmail.com/

Thanks for the review,
Omokefe
