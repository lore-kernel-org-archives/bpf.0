Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DCB1805E
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 10:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497381; cv=none; b=aG4knUBnwKZV/2DQs72klExc25zcDHENLwqa7PNO0v60PEhJVPViJiK3B+xrYc+eMujxtGXKQNu7vU6B8pd1a3KTEkFj+q3IarKI9mcE3yiJiODWbHv9sv0oWbirXiaz+kyLvLjcMam6+S+UIwAOih7/s/0ViL76ihfb0q0VDVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497381; c=relaxed/simple;
	bh=TybIA2rMg4/JM8qDSEPVvtVRAi/mcjYOqy1/lJnzuKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qodxBhbA5V2t3g+OX8chpJxjPmXFLtjO6cyd8hgad1PQsWqG/ZJriCCzOV6GL8dePYk+TcoGmVkI1/EPnVqoHfIu7h7RdJwLXHrai7iEAwGAokX29LzWF9c1aSi+Db8I9Fnob7mvDOi/rQMhRx1S9w51UaVcY0NSqmfDKzN79nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net; spf=pass smtp.mailfrom=qmon.net; dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b=bzbHMTZo; arc=none smtp.client-ip=185.233.34.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qmon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qmon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qmon.net header.i=@qmon.net header.b="bzbHMTZo"
Received: from smtp.soverin.net (c04cst-smtp-sov01.int.sover.in [10.10.4.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4Tx08d5KtkzFc;
	Fri, 15 Mar 2024 09:59:29 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [10.10.4.99]) by soverin.net (Postfix) with ESMTPSA id 4Tx08c444Fz36;
	Fri, 15 Mar 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.soverin.net;
	dkim=pass (2048-bit key; unprotected) header.d=qmon.net header.i=@qmon.net header.a=rsa-sha256 header.s=soverin1 header.b=bzbHMTZo;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qmon.net; s=soverin1;
	t=1710496769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bgwh6F9BI0BFak4J50ZAjsa99Jl6S+nNrNaserwK6ao=;
	b=bzbHMTZozkZo/Ar98g1zUftJ8hOdtSKGkBMo1AMDTb3f8nz/4oNrmBRwFmAhul4JtdyeSp
	BB9ce79HTLhj6Kfv09jqRst0llMt8WWICoV1WiXSnxr4ovb/yHG9h2WYjkyMYORt1qFnKu
	NNnneY3dgSASNaBZdxCDUc+ek1lPOJ8frnXJ1NymFmOQcjJIatXeOcIPLcOQtZidlGGXiV
	g0G9iTfnPqmLQqiNY74bNm86crHwb20bD0+/MObNEWgcVED34qHJcdGXdTLzUit9Fdz6qa
	3oIVuZpFZ2qLORIe3V/CTeRpOqHbqhhMdH4W2I7tmmPvXjlSlv3xWcHgOTL3MQ==
Message-ID: <355ad113-ce6c-4bfb-8ae3-8b1a37bdcda0@qmon.net>
Date: Fri, 15 Mar 2024 09:59:28 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpftool: Mount bpffs on provided dir instead
 of parent dir
To: Sahil <icegambit91@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, Quentin Monnet <quentin@isovalent.com>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20240308130619.28123-1-icegambit91@gmail.com>
 <c3cb7598-f777-4714-9e43-d9e0fbdf8711@isovalent.com>
 <10467264.nUPlyArG6x@valdaarhun>
Content-Language: en-GB
From: Quentin Monnet <qmo@qmon.net>
In-Reply-To: <10467264.nUPlyArG6x@valdaarhun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-03-14 21:16 UTC+0000 ~ Sahil <icegambit91@gmail.com>
> Hi,
> 
> On Wednesday, March 13, 2024 9:17:44 PM IST Quentin Monnet wrote:
>> Thanks! Apologies for the delay.
> 
> No worries! Thank you for the review.
> 
>> [...]
>> Note: you don't need the blank lines between the tags.
>> [...]
>> You can keep the changelog as part of the patch description.
> 
> Got it. I'll keep this in mind when I submit v3.
> 
>> [...]
>> With all the checks and the potential directory creation, we could maybe
>> rename this into "prepare_bpffs_dir()" or something like this?
> 
> "prepare_bpffs_dir" is quite apt. If longer names are acceptable then I
> would also recommend "prepare_and_mount_bpffs_dir" so it indicates
> that it'll also mount the bpffs on the dir (when relevant) after performing
> the checks.

The length looks acceptable to me. I used "prepare" to summarise "create
and mount", if you prefer "mount" explicitly then maybe
"create_and_mount_bpffs_dir()"? There's no other preparation step as far
as I remember so we should as well make it clear.

> That's really nice to hear. I'll incorporate the recommended changes and
> will send v3 soon.

Thanks a lot,
Quentin

