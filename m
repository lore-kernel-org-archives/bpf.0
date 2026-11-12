Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485377;
	b=w8Iv/mZOkGJ1EPgvGA8cRc+jrd+730XGR7JHQiU4SG9phH0TOIZMVS0pmMur0sGoXlKn
	 i/NQSIozhwBWv+0N9StttLDlleE42lDr71cAgXC1ZJY6iS6BTCwLiOIhbVThxLnjlf78u
	 M00NazJYrAb+QdKnjD82QtqcWRkbJ5cGJ39OYc5nINSYj2a7JItx3QCV9r97Zx2pc8ANu
	 RFGDKDsakRlBj9492veFG2hAGusAQUVooGV4e/V0yHxpV+ArpxCrEtYt0veEN3W5Yckca
	 qECTRbojudyzVyehR5mahKVGkiUmRRYRqm/k3BYh9T53TYQMPgwO8Db0FHtwDUoRq+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yVXFtg5uv6jmT0ohsABv7mNA4IYkbP/bTmshktkMt3c=;
	b=hauTKf8JEPNzWEb8mP3jEMaQcGnwoGP5vgDflNIoXaOS84YB/OQk4BlUIxiuEB+Xhpgr
	 0ab5ozuo8JsRbG5J1keKm0AlcNomcenZ/6MwCaG84PJ3haFxdJgrMvwN9Zo7LnjJcDJaW
	 etc7ol+LoVZHIm4srTFjNdF2XMQohaAz65ekkl3jC3NvtOZBwh/bgnf4DtjAjbb92iZnw
	 1LoyjNKjK9fMExcvKd/gRySDe3IzKjA2PdJGSHWg5DvKnzVBmoFUPByFXsN1FV9wWbr3j
	 Cd1U6ZppL/LMfkvwHH8khtHrV6pPZxNIwmhxNVbd3uP5aw8T/u7Xg4GIiidxVaEjajQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KnnbIB3F;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C65606A32A
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 12:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3C65606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KnnbIB3F
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-491aaed7565so2471527f8f.2
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 04:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794485375; x=1795090175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yVXFtg5uv6jmT0ohsABv7mNA4IYkbP/bTmshktkMt3c=;
        b=KnnbIB3F7KMniAR3dO7X6IyBVbtVQ6tOUdE6/JoML7aE/4n6QZgGrSdiBwUSrQqMFf
         ImyIjubKr2EwQDMCrRkIPXg8JcPztoTDeMIE3QgtEeiOmzRIzrIccGTa2b+I6zMIp0n4
         fvtn6drlA/T/F5B/c7/+9SgcGZGyH9FytYNNC9gE3wSUqSrmT82pfUIE+tkxgKh4Nk1V
         xnlX22vuw2JT4GMm8rea8JCPhMS18lnX4VJg4oyIMZb5hmf32AdsKorEs7gr82QgPDdy
         NfphP+0IvId6gFdVVRgr6S0u3eFgeZV9CFpIiFvn/gjOkpEDIdf/a/ACxQ5nlvlibDE7
         sJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794485375; x=1795090175;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVXFtg5uv6jmT0ohsABv7mNA4IYkbP/bTmshktkMt3c=;
        b=tO7Ebb1wPqudcJCCbv6w5OpUnX1ACuUtMmwNhW7x61cDXugFJqayQbdvAUk+PPZcg7
         AyyEB9g6/2UWeMomKMbGyJ6XB/IdAo9SbDv31HOXxW9QIga0DXFg0VnGq2ahay115rEH
         ARrsYGn+gCKaz/czB8ND+e5TOQn1cGvVx/wOMMXCBv/wGR7PPalLRzDrIWa8taBWr6Uf
         623J0HWxmyLEYAeMchiV/GJlDWLWT5WGrsxFxyZMsZiW8JvnNJqvm2YLAGq2F1EpWCHR
         YPqfIUFY0178A7OEsCilaAQGVCgw12aYulQjXqrh+XsULoqnE1/uskWvHVw6fIEQc7/g
         SXFQ==
X-Forwarded-Encrypted: i=1; AL+hErHFWrgJV9rhlsBXWI3sRedC40iggJXmcmMeG+e5VIKUODg9c6nMCtQ9bbD/gczsbqNu83Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z89cBxWqqX9Fci5bdbk8MyFb1J6POi4+HtS70oIvs2jNEgtirOx
	gcRGHeyhr6BsOd/WcDEkXT86ytYtx4qcKbDO/Z74bODuA3oXP5gVvnE9
X-Gm-Gg: AYBFou3MZOStEihIwLfWGquJNI9HYI1/5aELO6xVi4gMjfisKuwzRWBfBMsj202Nugi
	BJfkovLS6I1sq8kpSbR3CvoWohueBqGGyFSCaofKzwaVk1+p6lvmFCcnsqzA/Q6iDMc+gZEKKin
	0q68zeRcIg9DDI2pI+VBAEBdyL933L0Nbruwj2VRfq3NRCAaVP9w0s9OhAzDcYDSo3qSoqxtCB5
	Ue7yq0AmgnSLTefWX3hBadasa1c6fcOQn7WrhJodFHsA02vFr3crQxjP26Q1NyVtnIdFquvM82T
	D1RgnaSwgYQdudWhkq5yF6PhfOWyawUiUb8hoPAdK1TA2tzEi6ZsV3CsAZaCCQ1DJ/j9iRxbpJJ
	CpnTHkWiooy2QYOn26Vtnt5fKvM5oCPh4xOrxuE+l5JNnVsxEjS9eetx8vSOZzp7zuqJtbhlmvn
	6SEubb6WfD5etad3+mKWbzPge1Q6M5HAkTsqlIPcRCQs8qI0Pv9ZW7Nt5rmtElmXqb/xpGRLd0e
	uOndmock5Gkst5tlKpiemqVTpEdVbh3En24nvkOGGJTttWxayTrs9RGr1bA33fhl+93B30l+yqN
	zu2aCZFvD+4tCp8p/hkIfJLzNUffNk6cNQrxEA0LAPAWzEUkpLDAdLJPj1adh7T3Yg==
X-Received: by 2002:a05:6000:288b:b0:48e:2a04:4ea3 with SMTP id ffacd0b85a97d-499c3aaa3ecmr10258629f8f.8.1794485375130;
        Thu, 12 Nov 2026 04:09:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49895f4e6ffsm15149402f8f.16.2026.11.12.04.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 04:09:34 -0800 (PST)
Date: Thu, 12 Nov 2026 12:09:28 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, dennis@kernel.org, tj@kernel.org, cl@gentwo.org,
 oleg@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, bjorn@kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, broonie@kernel.org, dave@stgolabs.net,
 jszhang@kernel.org, tglx@kernel.org, conor.dooley@microchip.com,
 thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk,
 rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com,
 debug@rivosinc.com, seanwascoding@gmail.com, andybnac@gmail.com,
 menglong8.dong@gmail.com, cyrilbur@tenstorrent.com,
 wangruikang@iscas.ac.cn, atishp@rivosinc.com, apatel@ventanamicro.com,
 arnd@arndb.de, nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
 morbo@google.com, justinstitt@google.com, qingfang.deng@siflower.com.cn,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org, linux-arch@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v10 5/9] riscv: implement preemptible this_cpu
 add_return operations
Message-ID: <20261112120928.24145d44@pumpkin>
In-Reply-To: <20261112104149.38589-6-cuiyunhui@bytedance.com>
References: <20261112104149.38589-1-cuiyunhui@bytedance.com>
	<20261112104149.38589-6-cuiyunhui@bytedance.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Nov 2026 18:41:45 +0800
Yunhui Cui <cuiyunhui@bytedance.com> wrote:

> Apply the recoverable per-CPU address handling to add-return operations.
> 
> Native-width AMOs return the old value, so derive the new value required
> by the percpu API from the operand. Use Zabha for subword operations when
> available, or a masked LR/SC sequence that returns the updated field.

I can't help feeling that some of this code is the same as that for
normal atomic accesses.
Can they me merged?

David
