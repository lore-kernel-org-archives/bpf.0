Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198A3A1E80;
	Thu, 30 Jul 2026 06:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393715; cv=none; b=eKjHK7OAJSb1oARD+D7CA87YBFl7gmJHv3VcGob6w1KLjLm7/s63ekq51ye8OtsCgCx1yU6oQh6hyffDXaH/nKP5m7hLVxfWKN5X+VDucq1PF7iWYm0e7cAhPeKQEk2iVoadsyk2B0jCKzxsMMgeGsXjZ3LX4CjDOWWXdY791NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393715; c=relaxed/simple;
	bh=XdAOrei+mo9Q1jpmRkL6Q2Hn2KiAEHLWDOc+J7xOijE=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=DABlT1GVA/m412yYn+6cB7ROt7+CNXOlnzN2vFt3wAPJ7efpteYD71KYYr3PuTo8tuOzES+l6wxoWquJ2M9nUJ5K42KT6KQSkR0VjuaZxa9fZNe/E5Cy/iCmiJvSLIFbucM8telxD51uoMaSBragnRbEHk6x9aHNBJ8PCr0F7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4h9fkG4NNNz57HS0;
	Thu, 30 Jul 2026 14:41:42 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 66U6fTuV056898;
	Thu, 30 Jul 2026 14:41:29 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 30 Jul 2026 14:41:31 +0800 (CST)
X-Zmail-TransId: 2af96a6af21b7bf-1476f
X-Mailer: Zmail v1.0
Message-ID: <20260730144131377fjVsjc272-kP3_OMg6G5f@zte.com.cn>
In-Reply-To: <DKBP0J41TSLU.1V96E2XEEIOOA@etsalapatis.com>
References: 20260729141159128mEJmS_aujBKr-cBu1p_UI@zte.com.cn,DKBP0J41TSLU.1V96E2XEEIOOA@etsalapatis.com
Date: Thu, 30 Jul 2026 14:41:31 +0800 (CST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <emil@etsalapatis.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
        <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
        <jolsa@kernel.org>, <emil@etsalapatis.com>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: =?UTF-8?B?562U5aSNOiBbUEFUQ0ggYnBmLW5leHQgdjRdIGJwZjogbG9nIGVycm9yIGNvZGUgb24gdHJhbXBvbGluZSB1bmxpbmsgZmFpbHVyZcKg?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 66U6fTuV056898
X-TLS: YES
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 30 Jul 2026 14:41:42 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6AF226.000/4h9fkG4NNNz57HS0

The previous discussion link: https://lore.kernel.org/all/7e023c28-abe5-25a6-150d-ff8a782992de@huawei.com/
