Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB275304A5
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664470; cv=none; b=JC/EAPLmr6R3oXHCF1cda2XoSxCgCQMwafmZN30oaVDQeNbHCQC9tZt8j7oSjg45154SGz45CHsCLnEb/23eY0IV3weS2WUfwb6SU7eb/LmER3p9FLRe8qcEoaknGjCAENmuMQlCL45moWEdpG7MOZ6iMVs/rFhp4wIz0CPaYW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664470; c=relaxed/simple;
	bh=B2DIEOfiu6m2jYhcfQxwPgrR40S7t8sjAFAF5ReukeA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=TkQcXCdYJ9qEyDdILSyyREHI9NbNMg0DhiMp/LMU4WmwyAdSV9OnxQBO+Al20hqijvtZaV0twvUMgFZR58gtiFlfb/hDD4n4OVrAK9IOqb38VSS4u8JGgBQ1lmTK/UPRzkwECEqE8RG1XroZNFrc8JioRWbGza+CaeJQ9KiUPW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oP2U1C6v; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oP2U1C6v"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398c066106cso909673a91.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 10:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789664468; x=1790269268; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9r+Nmb9u1of9YV/2d3L5W7crVXgzglxIBbWntwiFrig=;
        b=oP2U1C6v6NEuEi16j4ISIERfcbQXIWC/tguAFAl/1xgyF+3FT/wu/+znaqKJj/iBDa
         ssMEyKWbUgRszefgZ3s5T1TCbePIyN/opF66r6MEpBq+oEbD+Xh/7yn7rtfOHjVtIf3/
         9Ze4VZR4l6LAETtv3bWgq9m/1Xsmr+KeWC8vKpzd2AQl9qbmIRC2Gbb7qnFA4jgoxT23
         +3ThUvp1elhnGCbnVuubwU/GgkUyrIqoBaXTkgAVzP2aNqAQQlf0JjOcY1CkHUKsSp9T
         +DLucLuiJYE1y2E5/vwnXRMKcMzsBG0UuRDNpMVIx44zZC6y+yje7HTw4kiB2N4s/dkQ
         6rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789664468; x=1790269268;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9r+Nmb9u1of9YV/2d3L5W7crVXgzglxIBbWntwiFrig=;
        b=oj5v6MUM/nuyg/SvODkvPAApdOfKV0l9hek2ALcH2lwvw1bEaS5iELwTDJVVNpJylP
         ni85yp1f/XTeJ3lDNR1T7VcRp6MZajOu3NroTcCJETHq9//yvcgoDX/AMjmvV5QZmv73
         VxAGkyuyiuN+U17zhGIS84+7b0rEpSzkil97AtKDN3RI9L9FKW0rudPDkHBviVrXNeDB
         PBCA0ShgF0HU7y0E/3X0flQopzv/45N9H+Vqsr4M3XppFi0sGG0zieEvpgi3+nnuo1t1
         BRn4Uz5ftlyZmCaPo/v01aSiarKKAdeotx/LVtLqyaCMNE4xqWFZjhmx5zzJy1lfOjlb
         cJlA==
X-Forwarded-Encrypted: i=1; AKwUvBy73Dx1WcAW4d0uXL2ZX/uFPBAe2r5+q40EZo9pXvO93bzh5sRfanaAWjo5EeDyx8y6YSU=@vger.kernel.org
X-Gm-Message-State: AFuF++mugeDY9JVVCYvXVu0CsqsdnsicabNrxjiKrThnv+yQ7o7BgZ8V
	Z1qrVv/XHQpgCX+X9RbrhI9tew4KUIv6WRvIxVpBFQJ3hsxy0w9JsFjP
X-Gm-Gg: AYBFou1ww6CCbKRk86HMclXERCcGLQb/32fgjr8n+zFBQyKDh20ejgHUApByJhALhvX
	990R18ln4odA9Knl2rt5HyORK7RDMCXyK7GqMPzIrWYrnW9tNNbyhYxrcQSP6QsbdMuFxF6z+ZC
	k39cLA+Ib0BsH1QTdVSfl/pB0JAA6O6NZx9XOGySLanJwQXQoKiByXF6ZMXGKbzwshQoPJJ+vou
	j4ILy0OSzG1H0ONbpgIl0gWgytLY+B+LJGgrVdE3tB9x05cC+rNWb8r3McuwmMuCDXPWG65/1ie
	iAW9mqICjIqDF902aEFkK/cd+gDfzLyg9cgfSH0WZz6ZJIxi7cCu4USjGjzVOzBvBLkPXadztvK
	FLgTYo8u6qOgrDgFE/XFC0rH9+tq1kHh3TvbjD1w5LJfBFOASoSDt8mjwGzYrfgrPcoNDgmG2aV
	zLwsavrLrn26wkQO3TdssEixokUWFsmO/5v+MUyRLFP2Uln0IiZQECIPYFqQCaMRpa+gPWX9pbB
	FUwrAkcOCSQBdab4L0pgWzo8hSsfdlvosyACm6BI50XYu/xeZXwoKHkQntNXTmntKXyXXbMBpt4
	f0sA
X-Received: by 2002:a17:90b:544b:b0:39e:359f:8539 with SMTP id 98e67ed59e1d1-39e359f8573mr16938434a91.15.1789664467801;
        Thu, 17 Sep 2026 10:01:07 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e36170735sm5918501a91.8.2026.09.17.10.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 10:01:07 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 17:01:06 +0000
Message-Id: <DLHR3TXGGQQA.35NANUU0VNBB2@gmail.com>
Cc: <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
 <davem@davemloft.net>, <kuba@kernel.org>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <xmei5@asu.edu>,
 <stable@vger.kernel.org>, <co+ac0a8c41de69121d@bugs.sh>
Subject: Re: [PATCH bpf] bpf: reject dev-bound-only programs on other
 devices
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <bestswngs@gmail.com>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>
In-Reply-To: <20260917161335.1020405-2-bestswngs@gmail.com>
References: <20260917161335.1020405-2-bestswngs@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Sep 18, 2026 at 12:13 AM bestswngs@gmail.com <bestswngs@gmail.com> wrote:
> @@ -698,11 +698,14 @@ static bool __bpf_offload_dev_match(struct bpf_prog *prog,
>  		return false;
>  	if (offload->netdev == netdev)
>  		return true;
> +	if (!bpf_prog_is_offloaded(prog->aux))
> +		return false;
>
>  	ondev1 = bpf_offload_find_netdev(offload->netdev);
>  	ondev2 = bpf_offload_find_netdev(netdev);
>
> -	return ondev1 && ondev2 && ondev1->offdev == ondev2->offdev;
> +	return ondev1 && ondev2 && ondev1->offdev &&
> +	       ondev1->offdev == ondev2->offdev;

With the !bpf_prog_is_offloaded() check above only offloaded progs get
here, and __bpf_prog_dev_bound_init() already rejects those unless
ondev->offdev is set. ondev1->offdev cannot be NULL. Drop this hunk.

Also drop the "attacker" wording from the commit log.
It's CAP_BPF + CAP_NET_ADMIN.

pw-bot: cr
