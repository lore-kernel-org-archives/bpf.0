Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DE5175A8A
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783642424; cv=none; b=CHhZf8iGAD8wumtYfK1yZ70PuE9N+aeUCJcTKhaTezUUgzWg/lTMpPLLvXmmVkEEXNc12rkwgCS+OrJpQFXPmmsMJOd6qb5hOiODDuWQKsPm5TBOVC6DmK1L+ct920Zy2xww19Z2D9FqZmr2PAcl5/6kPjfPTJ1CCTbHL+v7/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783642424; c=relaxed/simple;
	bh=thvftvBatjKZR+GPnk6us63Rp1kjylbihEf1IrFFa6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM6LiyKxKjLy2JJOjBlUlzQvOWsobWJ2+qTsqxWNyV2iJkdWrYzN1Bf6WaOo+yhqR5kjm5OKKRFgcYVN8AHqjYX3LTyKRjlH2wkyMtJCQbcZTBInIF5iz80wqCExfUnOsSRo/x8iV7V+I8cQMU+H6lMFVmk1oeLiCgnaFJVIO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XH2llc+X; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH2llc+X"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2cc61541f8cso20421405ad.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 17:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783642423; x=1784247223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y8qOpSBsfUs22KItaR0neP8aEEt8SwOwfSruEwWXFmM=;
        b=XH2llc+XaQ1uD0JC0DP5vbwf784vyFbdOVYMbuSPSd/FtDCOLhhPTINp7dGO78ev+/
         giJAy/TQnCoWzsNXYPnNTjcGNL8OqAnu/tll5/66TZOtMqrAgioe7ak/+/DZ6D/plsix
         ijqUClR9mFp1f05gouPv447PH6l+axK/RwbvquqT24IIlff6peWCbaE1AyFlw0t5UuE/
         VT5XfwIixRW/lgiQ1+DcPeeoWw3hHxzcercBQcwddtLsUxHjvZTJlpMe/kCdPmHEtu/i
         2O9Gezqus1xU2a8xtsFL/GFuNIOVwjMjZRyEetLBatsiIcIQW04jxzsfvhbbnFLJFHmY
         nciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783642423; x=1784247223;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8qOpSBsfUs22KItaR0neP8aEEt8SwOwfSruEwWXFmM=;
        b=LvKAOG4NIApJijxYrSX+QDhHJAPs1YnAMrXSl0gCR9/qmlBWmY2NSyw0Hqd1Os3Zna
         UP8uRxcdyQsfhyWc4ANRqePKzFvyY8yWLzMPWn7FYwV0oVhb2fS6zBFfraexz3BhYDe5
         B7pCqUyu6gpp9/mE7dwIWlVJLPeF/AOupNoVTXBRn2rVglHCu42+i5BYvzdtr9qSJ7NR
         4PGWA3N20TJmgMik71fSOjPDGiQ28cizOqJPiJhrmYtKQV94pjWRSLKIFyBtTtNtLXYU
         RzE1rn0SRTDgX2eKP8kdfPyKCuC1GLq2ZU6ri+J5pnj50ryO9UbIY2kgQOBLQdzssgiF
         8yvw==
X-Gm-Message-State: AOJu0YygVTY9K3PboKxxwF2kLU2kdLrqMUKYfkwy2Kh1DaHIzhdZmfW4
	j5bN+A3tmo0/x1inwoMaw4a2aUU2gq0ZZatFcEg1fEpiPCj/qJWQXm9W
X-Gm-Gg: AfdE7cmq2g7KroX1y5ZskbNVbtXjehy9B8dps1cmHmexXB76g8ROxE1isuW3NAcahmD
	sT6VlJSmEO/fdecajKUQqWtFQHhyxTW4RbM+E8ywsHIDeKPaiSstWtd9JxXvyXtqo8iMKVCLTq9
	ZW7DMtURFxeL38ZHxfQlNyDVOdVbBW+mhHRcGgDbe7FozB100XpGORiiyXNwQRUWfWXtjfmxpVz
	Z4cwXJRYyazkI/D3wkDuZest/qNsHsI7kcCnVRkwjKVgHLc8CEuStUmWA0YnuB2ZuzNBfHwyJIi
	/rjQCQapEfTz8CRZ4RFtGMXJ+m5iWVX2GcG2rcNr3PcrgnU3zrNUynrUTnfhvu2tnEGAygr78pE
	4FUrpo6SrPFHXQo/amrQSeGxICc/ykz1sCrg6KGb5P4TZRJnAqtc36KP3MeGXyDAd18wXiuUnwa
	H3f57sznLph+cXBip0
X-Received: by 2002:a17:903:4b2b:b0:2cc:db7a:251 with SMTP id d9443c01a7336-2ce8285a73bmr12198765ad.2.1783642422634;
        Thu, 09 Jul 2026 17:13:42 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3c99fsm51196295ad.68.2026.07.09.17.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 17:13:42 -0700 (PDT)
Date: Thu, 9 Jul 2026 17:13:03 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, jordan@jrife.io, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, netdev@vger.kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	horms@kernel.org
Subject: Re: [PATCH bpf-next v11 4/5] selftests/bpf: add bpf_icmp_send
 recursion test
Message-ID: <alA5Bh7tICCSqgX_@devvm7509.cco0.facebook.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
 <20260709144900.245904-5-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709144900.245904-5-mahe.tardy@gmail.com>

On 07/09, Mahe Tardy wrote:
> This test is similar to test_icmp_send_unreach_cgroup but checks that,
> in case of recursion, meaning that the BPF program calling the kfunc was
> re-triggered by the icmp_send done by the kfunc, the kfunc will stop
> early and return -EBUSY.
> 
> The test attaches to the root cgroup to ensure the ICMP packet generated
> by the kfunc re-triggers the BPF program.
> 
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
