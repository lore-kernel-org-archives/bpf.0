Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE631E1A17
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783907112; cv=none; b=ZtbnA5kmWheSQd3purMhX5yvYztNL+jPfSG679zO5NqKJ39/USDAuBFyBAUmQI6HcrkMulqKsovy9WG4ldJ/TNX2yGMSwPERyvr+rcp+U3eF936f57/W+CKe3k0doHuP7U2qwL7F1KbwBc/l4ZE3xJ4Qc62IwrHlIfVHZPqN4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783907112; c=relaxed/simple;
	bh=jbuVd+3yWI1KKSF9IEv8yv62q2gLX2KwoLbDQKhnegg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=VqglXXKLs7KPkv3O5QeuPbMp/89CCcxWycKyLZXG/pBquyWpb6nwIPrj2hMevhf69uhuNANRgGy6ikTAJHpZlJCtm33sbZOgEqNGEnaK5IfAO04Vn9rOH0Tq0vBCOGvhe41N1LZP/iUN0vjq1OflwxDidK58r4b9wlEUzHdq6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=VBgM5Jtq; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="VBgM5Jtq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1783907101;
	bh=vloHTjUoDqe+CO3bfMKdvGdO0jLWtIGZLqd5dSMPSgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VBgM5JtqU1bq9JRvFQFf6uEx4U5oKQw2fWi6i6R/qD644XwDVVzAYfF8QE/7367+7
	 GgyCVJGZBxc2x/RimSonJGjyVGwVBLY9yBkkIAqVPQVi9jNpmjDqsnfdOGEwS/dYvB
	 INvtAtsZfZEEFmhTGOPXOmBbLbwRF/CQ4cJXXFsI=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id B3ABB49D; Mon, 13 Jul 2026 09:44:58 +0800
X-QQ-mid: xmsmtpt1783907098twkcp3akh
Message-ID: <tencent_11D368A068A46E0B3254659454849AF37406@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUA7DO50BwPAbc7FHXS04cwukYOqD//JXoHhqII1upx0QS781H+s/
	 Kx6LkTgphMTGK9o+bT233Avtmbk1aFUCOU9PuH7dbyWHNqG7+OaoqhAY8XLW0yMyLD9rZzzP2qOS
	 zuGBgM4uQo/lXrMnihKi1Wot94zxn1AKIjKk8Q8nV9trybxZfb2J7YWE6Uv2TZB6VkOLwg8DS5Nd
	 H/RLk99nC28deLyiitw+WDbj/RroeOWnVjGmqtpt+lB0fC8tC/e+9UozkVcLwEVb89BKlONISThc
	 jI7C83Np84uqgN0bVkgER4payLTmVpqB1RcgJ6V/mrIeLSwu6eTD40wbPWJ/VG1apksvtZphG3Iz
	 DDib6QaBRCE4B5B6kfiLf5N8pwlzunYXr96byn4Gl20uiGZehu0iqxNeOSMwxHXwUHUKYwGoyC/0
	 hhAG9o9KDxzNCZU3J+jZDX89rW61tRTpcokGxou6iRHrFa75XayP3QjvJsmzURvi5sK3ixDR8P+e
	 Hra8oBFxzeRF5s3Hzd4l7bN+b13dQj7mERjHHgbcNAKJaoUOpbVjzWBWNx073O/ajQcII3xsKRLR
	 bDdPtZxq1zisvbXS4ZEtEj7ElLuCon4WfCYulSXEk6vmwbHUULMcBc3AiwHlfvwzWFKnrkPknY7K
	 goL8fBiIJtChgLhAkyJg3d6ptoJdmiEIeuhVSpnKyUx6rS4LMSkqSGAYQeAaWgU/IBunkB26z8La
	 sNEYLh0PziYCKeh0KPBxDT5unM5L0wsxRL/N4RgW8j1FBGh7lfykG56r5aLc7EyI5092uleNodyj
	 KtoyaYYYQcvDcXQYdTHldXdcmJRBVHdxUj+1aQhHB1j52yG7YmjqwpwfQ7qDWvchmB8Ehmv3GfrI
	 xSrTCHD4l7V8zZlEcKTi+EnOXAX6kkiaTaAMGMHqRItHjEUd/idwbX3tVZfVqUVR/Cliuhso8VPl
	 WiBp48Tr6Tlpx66v6QtxWL1jN3pckQtcwovtugz9ap75Mydj78Ot/0nUNEWTmOathNt99xxv2Ofk
	 nfMQ/+iQNwZQl3k8SymBuO1QSvWKuKXYunWoUn8peWU0Ql1SoZGPDRstqT6bc=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Subject: Re: [PATCH] bpf: return -EINVAL from bpf_ringbuf_query for unknown flags
Date: Mon, 13 Jul 2026 09:44:58 +0800
X-OQ-MSGID: <20260713014458.1758859-1-shijianlin11@foxmail.com>
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

Hi,

Thanks for the review.  I'll drop the -EINVAL change and send a
separate doc-only patch for BPF_RB_OVERWRITE_POS.

Thanks,
Jianlin Shi

