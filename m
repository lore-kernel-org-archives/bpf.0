Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2A7298CAB
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 01:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790041024; cv=none; b=LfxycqSbBC2Y8uOHW8ipMBuWw6eNtSUZtinN2De+Zm1K4bBXJ965cpOm6SlMm8MuUyXTI859j/2f5mti1sODV07ZfxuJTqwTm9YjqAGo9rrBBOU6HlMv843gdB2pOY0kEKfJKr0NSuK46b/AJacmI8Lpd9MgSZ+3FphWOwnslK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790041024; c=relaxed/simple;
	bh=GEDKcBH0NluAvLi1BOy8NlUKRWuTQ/8y23ZGvDtrNC4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=SdjJIL/vUE5raXiaGJvMwj9ic0ab0DYGEKOcW9dwrrqNQVNbMocYCoKgWLbSJ0JZeDIbHJNFtFhqtBUcuVm3VVsmEcbVWG4RKffDhrf5EXDbXgXYtppcy/eMR+qIK/1M0pfJNcaI+zNkT1Fx7ZfBdew97aaZjvHsOkNZm2CcNRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nom571O4; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nom571O4"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2d91a931f66so25191455ad.0
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 18:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790041022; x=1790645822; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GEDKcBH0NluAvLi1BOy8NlUKRWuTQ/8y23ZGvDtrNC4=;
        b=Nom571O4aGz4B6Gt/aA2iQ3r5eBlhF86R2JPu4fQl0u2C47TcNXGBUiJV4o7AhNfaT
         y/slpEsUob0WWQIeM39eauco/SKRsXyc6/I3h8SAnzyWFryuB4kONDoud/T0JoYDx5X1
         W3ft/PjjfXGfvgtMv7ndUDhwreyyaVQfCfhfIqVMqp0sMARzoISUrenXBc16XIFKUbuS
         zdAA7n4N1Q65tCItMV0XGVvJxG95yawEQgI200tanYS+70NmNfPJSCfN/oPMDzmoEA3k
         UvaHPtn8izWryfuQAuex/jNYC2sF3CUjRY1Z4rB3+JhShM4YngX8iEJJsVADqnGH4VjU
         CwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790041022; x=1790645822;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GEDKcBH0NluAvLi1BOy8NlUKRWuTQ/8y23ZGvDtrNC4=;
        b=di3S3aChSUGB3LJCDycNIR432SEofU3ouWE6Dw9tT6wBlNUBKmW8wgFWmB7H7/vQCV
         occER5PdOd4ZBFWB2sRQ8NqdEqdY3vlBRuUKnq6to4i4LagSPn+uUucHNgf/JAAe15O9
         E4NRdmBsWLugA4+kW8BxMJwed+YDcvS4cai1FMWIeidjRbu/ttEncaNHcOxuhQJPvHLe
         b0lI6PjRt9ARmg1O7qHJAspP8WlH2CvTCGex7Ax9zS24ivYJ64fQZv+nUZxd9pUtnU+C
         FBcqE8Vh8yy/xKOC+qiliDO6oxT76ShycPXIj9ZTlR8C3LiIudzq0I7C3Wj64v4M2juy
         IlVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOWqH1gm9WyZLZCgwhbzDQoFE6neKo6+DBATBEAfyMWK74+PJq+cpgsru2hiUTTl97K9w=@vger.kernel.org
X-Gm-Message-State: AFuF++nozFAbnfkeHdDZGAA6ZtgUJlL41aflzgqIY7+Gt08GbOsqQAvN
	vUPxiOWeDuIIbimlGgI6+fpvGpS4gbfcW1KXKzCf1f1qVPp9e4mCMXCt
X-Gm-Gg: AYBFou20v7u9/8oph6LZcq2UhQ8YgsTm2s5tNQu6c5jtjOdBFCUtmDMfJp9qPFHdEWo
	Gd1aDZQMSPqUT1kyQz0t/M4IwN4F5ucvuHuCoBx1Pz/fBFRU7v0eguxW7aUfOyaBbjLV9FqUDak
	QjODawDR2hk7ZYGs9wvtsuRDLFFsE3sQxt9kRz7myL319G5Yi9B6Z+ekbbVAmbgIOG8hdfMjwAC
	/CR4qKwhcYtj2uANOuIppwbWLfc5yfRaF864mit7KAOkSehSfQ/RslS6kOG7ny4fc4atY9hdGVP
	NioLgJxOL2gXjWUwNbFl9Joij3+95fBxZcrQfOsbW3S4YJO+JZd9W6Q6L6O/5wYlu3Fmi7ohQeo
	14OTpPx2WFbOfIWm4mmE+tXRXsyRyA/ofXv9L7DjVq5FPkG2tCakGKsf/Dan5da7h40zYUnDbut
	KB/xilF+ZIC3Fk+rprGTaptBzTGbwLVVCBlIknfwZ/1DogXum8Lkeylg7lBsyoYV39k9iPJ8Hop
	GXftZIeGKJaIsijN3vziZXFObRGTiCiFvT8w6bDJZCVgt2NvuNarzCZ3Owrvh5thFhTP3sP1zY3
	8H6EHCPkXSkcgQ==
X-Received: by 2002:a17:902:c412:b0:2dd:c053:d740 with SMTP id d9443c01a7336-2df5a61aa5amr14129065ad.39.1790041022085;
        Mon, 21 Sep 2026 18:37:02 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df5d055c5esm1046115ad.66.2026.09.21.18.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 18:37:01 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 01:37:01 +0000
Message-Id: <DLLGL0Q2REDU.3CMU5XBIMBWGC@gmail.com>
Cc: <martin.kelly@crowdstrike.com>, <slava.imameev@crowdstrike.com>,
 <linux-open-source@crowdstrike.com>
Subject: Re: [PATCH bpf-next v4 0/7] libbpf: BPF program manual loading
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>,
 <bpf@vger.kernel.org>, <andrii@kernel.org>
In-Reply-To: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
References: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 21, 2026 at 06:39 PM Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:
> after the initial bpf_object load. This v4 addresses all outstanding review
> feedback from v3's two CI bots, folds bpf_program__load_manually()/
> unload_manually() into a single load()/unload() naming pair, and adds
> a new patch that properly versions bpf_program__set_autoattach()'s
> ABI change instead of leaving it as a silent break for out-of-tree
> consumers (see changelog below).

What happened to the veristat conversion?
In v2 Andrii asked to try this in veristat to see whether it can replace
bpf_program__clone():
https://lore.kernel.org/bpf/CAEf4Bzaf9AMBUWQeUj1Uor8F7A-tOPpVMa-CjRB0MNH4zRHEeQ@mail.gmail.com/
and you replied that it builds and passes test_progs -t veristat.
Pls include that patch in the respin.
