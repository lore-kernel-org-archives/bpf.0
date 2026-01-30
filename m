Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F133D4E2
	for <bpf@vger.kernel.org>; Fri, 30 Jan 2026 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795118; cv=none; b=bm98zeZLNqtIwTMYvSo3lzAzF71uTxn8ULKaBL2lVffB5zUz30tkoEJqPqZdQdzRGOQeGn+JwzgteqTNbvJkym6Yq6paXTozhTtn72n3VIT7D5esmrOGP11xdiLeYV3dOFBxXfi7HOnndN6ezswedx54qMxueHwRN13FYzXfBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795118; c=relaxed/simple;
	bh=6XISFnwseCiWle6bCCXT0yDlbArJXGMqSLymypJCKt4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FYye6Aau+BXOEYvXy72HXHkM/US4++vrB1t3uM4cAa7W8fUR6/F1JfayOmM/sR5D89OE+NC/pDnJb9/mLKDpE/Mkp9xsZVmNRlK0jZ25qViouRz7USquWJPhsBs93bxElRL5Ba8belEaYCun7JlBqVHLZjBI91OlgnX7ns9HEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cXT6Sa94; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cXT6Sa94"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769795111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6XISFnwseCiWle6bCCXT0yDlbArJXGMqSLymypJCKt4=;
	b=cXT6Sa94g/FXZxZqXnTzJB2MKp403aqaQL6P12TRbhkveGjbPghqAkS7wa4Sn+VMPwjdbL
	XEkGRbr4bV7Ch01JPMLVLpOs3sknQpLOxfiaL2h7kaMnfglomgWFBTIPeRiqt7qk6sLwZo
	aXDUx8OtXV5e8AZDna/BzoJ2WkdfnIg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: JP Kobryn <inwardvessel@gmail.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Andrew Morton <akpm@linux-foundation.org>,
  bpf@vger.kernel.org,  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,
  Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next] mm/bpf_memcontrol: Add missing newline in
 pr_warn message
In-Reply-To: <20260129035014.3283392-1-hui.zhu@linux.dev> (Hui Zhu's message
	of "Thu, 29 Jan 2026 11:50:14 +0800")
References: <20260129035014.3283392-1-hui.zhu@linux.dev>
Date: Fri, 30 Jan 2026 09:44:53 -0800
Message-ID: <87pl6rknai.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Hui Zhu <hui.zhu@linux.dev> writes:

> From: Hui Zhu <zhuhui@kylinos.cn>
>
> Add missing newline character at the end of pr_warn error message
> in bpf_memcontrol_init() function. Kernel log messages should end
> with a newline character for proper formatting in kernel logs.
>
> This issue was pointed out in
> https://github.com/kernel-patches/bpf/pull/10864#discussion_r2735018210
>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
