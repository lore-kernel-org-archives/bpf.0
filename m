Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516485;
	b=GutBQRpuOMtYLKLor5JI2bFcCYfT5PiZByYWeI4fTsnKJPJ5wY2QJURSj3NKomQoU/EE
	 sri3jNGPI1mdvI6djTegD7HLZw7uFnVgKpubcxLlOEOep1+AOU7RVNYzCGJhKf3TnnUNy
	 QDDhe9cLtZ2De1gO2mONoCudN24OJQBWDrW5kZqPgCW5bFLcM8BJ2o7E59R237zyOJON9
	 ZfA81hbsn5tGsAVekaR22bDNPZPVcyFxkYV6Zv+LkC8i44WWN6aGk3s7QdpixMqJs0H0O
	 XPGJL6RVl5+XdUQwn3jPfpk54O5iTRvDziL6Vxkd4CeeBsvsuJPYXNtIachLvhsbotQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516485;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lOwnGQXmS8evHlFVLwX0xtuDnhg6yBqOr9ZK8AmqtFQ=;
	b=ltEoceVPGF5OJu+rmOSBfn8HLxyvzWMDL0l/sRFWzM2DHJLvcHXo1jMt0tg8coXj3pbU
	 5Fpg+B30kWlfz/A/UI/R0rdw40FwYyFasZTJrkYLASi+qZnSYvORy5DSPJBTW0veyS1P2
	 XDRxKf+0COL2RSDuSO/7Moo1QZPrgng8nhImow4F0P1qKwGShrfKXj7+VDr6/clC+RiQX
	 8QXh1tYPLdE8PdUrizxglOSWgKQhNsWK2AbWDTynZL/9DmepZ+r2+U5WOa6WWUq1n2awy
	 jeVIJAzvEAGxuccB4NnGQoO9Lzc8bZvBYX7W9GYRk+nhvJq5dzMtyNL4RLcpg+urYaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YrbUqHU+;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XrcILpcV;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A3606A32A
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 20:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C61A3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YrbUqHU+;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XrcILpcV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794516483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lOwnGQXmS8evHlFVLwX0xtuDnhg6yBqOr9ZK8AmqtFQ=;
	b=YrbUqHU+rHcmSyyevIaNaoiXUMa2N0Kvot6Q+zVerXXVvKOxuOPK0M6Sed5DGbzU6dkOS7
	fVTxI/xMYbuQUR7ufhDNmwWhqwOI7dSExJMvvYQlEkOqPnuj+zyivdbg0E8rug7Vrm0ewA
	AV1XWjyUDNbr5vYl8WlKYDkeMIAoVO8=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-RkWISA9HOfW6R1_Ut7VFbA-1; Thu, 12 Nov 2026 15:48:02 -0500
X-MC-Unique: RkWISA9HOfW6R1_Ut7VFbA-1
X-Mimecast-MFC-AGG-ID: RkWISA9HOfW6R1_Ut7VFbA_1794516481
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-4566537e644so297473fac.0
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 12:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794516481; x=1795121281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lOwnGQXmS8evHlFVLwX0xtuDnhg6yBqOr9ZK8AmqtFQ=;
        b=XrcILpcVi768ekJQkiC6az4W/O0HPMyYmAmrrucrjsC0hI5lPjWzPKtGVXVrPb/dhf
         mKJi3hUwD03+UV7Xy6OaeqHZ6kiYXq2Vi/JdrO5CCIpD7aYGwqcz40MxDbeO/GCduMho
         Ht6+Jb3yfMALIrFojQBCuihl7Po26goyI6uI4KHe0JLu2KNCg26Ys6jEvlFyYKSJPiMa
         B2cRnWyz0uXpBoMNCUY1kPpGuPVJ4MjYYqQItmrW0/chATCt5G3ehy/53eSqR2tmn4Sx
         3phun0NRzswUh+bs3xHt6nj8cJ4M+0cdfSlxpR66cZsU5LP0emccfjnc3SwylUeytqQl
         QMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516481; x=1795121281;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lOwnGQXmS8evHlFVLwX0xtuDnhg6yBqOr9ZK8AmqtFQ=;
        b=TPwTySDcvtzMzUVT/yrajlo2gzstrGut+xE+ALhVMNhqqmDqvFNtvUgiNXMPWti/Ut
         klTJ6nO0+fqPiKD6h0r+OWefXqLXWgybmuj6y6FByZlgVs4ioqrtQs/OnIRyjrCNVxRr
         7OCwVyWnrzeNIK4sz4N5fYBL0U0iCuC7qbtfkrhYYrh5HHz5r9YvNb9odm6dldgSy0eh
         RqFdPITfybWoMbnbYIPYxuOhEJ1UG80akcQQrI8866qBlxoBK9Ba8dtIFDyh9K7MqvSP
         XgqBvOo9wMFrkkbZkjD1VLZYlHOcTF2uF23yYptIjqvFbb9kZMjZXg/CnJT2bQYXTnAd
         xxSQ==
X-Forwarded-Encrypted: i=1; AL+hErHcKahKpp5uTnVUZ02ZF3r8uwYK7uH+vVf9racw7PgA0fclmmtruRGvzwzcGqvzVQ1WIss=@vger.kernel.org
X-Gm-Message-State: APuU4Z/U01ykiXN4Igwv1iZTheVLdCnEjyP5G9xxXlwN6ZyB7D5qiVlR
	AOIsliZia4BWBd47rcnf9agcoR93/FGbsBDv0Dh/WtEn3m9GBekDjTfsmmKA/r8jjC3lJ6AWvKd
	5csF1V1vz+nMkoXv1Lo7KdpZo7hBoeLrGEobMzEd+pd4cYy18za8s6g==
X-Gm-Gg: AYBFou2ai19Ujk+zXTEmRrn0GErOjScINNd+khUHqcLEUogVgFdxD5sYDL56YKmWVXN
	hPF1LsHC1b+sdU4hSfohjSlZKq0Tsm3kGkv2TGmOu/CS2OJRZw2Zpd3E1PDzpYtevQHzWF3/qn7
	fUH1/DaBojgZzZVpeCUiLzCX8xTuyAihrCJe5z8N6cEShOn0TfWEaA1nrVWhEgBz7hOhMH3mAS4
	sNdwd+r4VwEg01so9XZalsM0+3pjl0RTbOij0bGsvM7s96UYFvKv9/Qu91VsI9ubQxu9u+YhBJX
	eRRlCKbunzYvBesZQY+sYelbfHF1Pv6XwGoIM/Ec2dyNe1fGUBjc74KDmObunoTEsOEr3oueta8
	pMO0PzTfZoY03Ua5vDT58VMWL3GATdV9hO+GgsTKpTbgEMrc7nReb
X-Received: by 2002:a05:6871:7b0a:b0:49d:ff8c:205e with SMTP id 586e51a60fabf-4afdf2da638mr911047fac.29.1794516481342;
        Thu, 12 Nov 2026 12:48:01 -0800 (PST)
X-Received: by 2002:a05:6871:7b0a:b0:49d:ff8c:205e with SMTP id 586e51a60fabf-4afdf2da638mr911021fac.29.1794516480871;
        Thu, 12 Nov 2026 12:48:00 -0800 (PST)
Received: from sgarzare-redhat ([69.196.88.181])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628813465esm686251a34.16.2026.11.12.12.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:48:00 -0800 (PST)
Date: Thu, 12 Nov 2026 21:47:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: jrmmhm.kernel@eldare.de
Cc: Bobby Eshleman <bobbyeshleman@meta.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Michal Luczaj <mhal@rbox.co>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5] vsock/bpf: release sock lock while waiting for
 data in recvmsg
Message-ID: <avYllBVgJg2AHYc0@sgarzare-redhat>
References: <20261109-kbh3-1-022-fix-v2-v5-1-4d9af04f0fad@eldare.de>
 <avXyzxvIN3ngFepE@sgarzare-redhat>
 <179451283622.7.13355395779239029915.1767743913@eldare.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <179451283622.7.13355395779239029915.1767743913@eldare.de>

On Thu, Nov 12, 2026 at 07:47:11PM +0000, jrmmhm.kernel@eldare.de wrote:
>On Thu, Nov 12, 2026 at 06:23:00PM +0100, Stefano Garzarella wrote:
>>On Mon, Nov 09, 2026 at 09:08:29PM +0100, Jerome Mohm via B4 Relay
>>wrote:
>>>The loop
>>>and the zero-length check belong to the fix (without them the reader
>>>returns early or spins with the lock held), so this is one patch;
>>
>>I don't understand why that fix can't be in a fist patch of the
>>series...
>>
>>>+    if (unlikely(!len || (flags & (MSG_OOB | MSG_ERRQUEUE))))
>>>+        return __vsock_recvmsg(sk, msg, len, flags);
>>
>>... I mean, why this change ^^^ can't be in patch 1/2?
>>
>>BTW I'm not asking to split it (at least for now).
>
>It can: the loop is needed for the deadlock fix, since without it the
>reader returns -EAGAIN early when it wakes without data, but the early
>return isn't. A zero-length read with data in the psock queue already
>spins with the lock held on net, and as far as I can tell from the code
>the early return alone fixes that, plus the MSG_OOB and MSG_ERRQUEUE
>cases. In v4 those reads were patch 2/2. They went into one patch only
>because Alexei's diff replaced both, and my v5 sentence justified that
>badly. You said you're not asking for a split, but since the early
>return isn't needed for the deadlock, it would fit as its own patch:
>should v6 have it as 1/2 and the lock change as 2/2, or stay one patch?

Yeah, I'd prefer 2 patches with this change as first patch.

>
>>I saw some comments from sashiko, can you reply to them?
>
>I'll wait for your answer before sending v6, and I'm replying to the
>Sashiko comments separately.

Great, thanks for that!

Stefano

