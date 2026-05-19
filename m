Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5401340415
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199471; cv=none; b=lQnT6y528uuQ1K4dtfm7rdcd6STpj9TmCqUpXYqDnX4v4KaGJKO7ygE5yLuzUlgcb+TbTD95GRfeioTY6iejpZT4SCqyaNl8zZGxy25XUdo1ip0K+1H0QKmJ9KBCTKvWmIrgB/jrmuQ69nOYiHE5B/dzAidgditGVp35g29uDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199471; c=relaxed/simple;
	bh=FMaMUKz/x8QbjfR3g5V6+iL3OxM0o0sNRaKeIldoQQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STBTsl5qxPW8tA/+0446Ze6s307DyBXUJCU2VfWrLQLyNav3J9i0LzAu+SskUI1dP2VZDziWZ55gV2KGlGTyWxj1Wn9MgdFhsK1Z4xMomXAjvGJflG+LVDhCZ91U1InEMwCz57pQm29cDDCynaZZkMRZFL6PfNsmOO6d4dDxs+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIP7vHRb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwGqlPGP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIP7vHRb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwGqlPGP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779199469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyK79IEx4ySepGt4cTN7KOjcr0GF19I7WDCAu3CkGGI=;
	b=HIP7vHRb71zr8huQVxHBgS6+deoqQQqbAkdjOO1AY6t9DPSLv7/y/utjb9xthpYDJHqmci
	GkHhTBvHLryOPqooyYjJGRCIPTE2pp6HNoaWZsCoMdbmOFO4DkS0+3XlxlaGLZlsiB22hi
	H/h9GTTLUEjKp8+lrKqoCYIbS9Hac6A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-m0Q6-RJrN_CJrHc_oS-ONQ-1; Tue, 19 May 2026 10:04:23 -0400
X-MC-Unique: m0Q6-RJrN_CJrHc_oS-ONQ-1
X-Mimecast-MFC-AGG-ID: m0Q6-RJrN_CJrHc_oS-ONQ_1779199460
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44dad1b938fso2202965f8f.1
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779199456; x=1779804256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JyK79IEx4ySepGt4cTN7KOjcr0GF19I7WDCAu3CkGGI=;
        b=BwGqlPGPyTAEKuDwo8sJ84HiXt9d6LyIl3O6pJQ3hFJOV4X0PKuplQNp5LYIT5tB3W
         jvYM2P1TV4Ezar8/q2HeMsjw+6oduw9NQD8f/Hb0CxUzal9g5uUqJrYPYRRryByceluC
         dN+sGVRQWEkkApEI9FS4l42ymmv6oRo5fa4yDkCGQYSpQJ+2Kw/S4P2ZS7+TICNjVrMc
         /H2GzVj7PBn6KpvYWQafxXhQfq5dJT5yS3XCF4/o9+sEC6gxlvL4jze434UqMaL0jH3F
         ekmJ6zok9+j/itf1kcEJY5lMyadAa/kjXBfmEp9QEGC+/nTaVVsIpHljlx5YsJjmxU2W
         G0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199456; x=1779804256;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyK79IEx4ySepGt4cTN7KOjcr0GF19I7WDCAu3CkGGI=;
        b=gej+tURx1Sdf5aWmTsiQHfW/f2EEReOP6SHWcrymexJz4p7zbyAnNx12CroVhVqT3b
         8rAaJ6uK1QRx/gDZXZJk4Pd72q8CKt6Kycd7E9QFkBA7pffloAEJF6IeJOnPLiIoRjUk
         iPb/Q8/8toSJ4xjl6cjWwf1LAT4BisEnXuS106W/4FWwpwA2ylcT8boJGY8Tf7Ul729u
         eUx8Iu+weFnX9WaU5x+RGuaCHudtsxk1YnAfJuaTJ0/MDU8bqC+002TKEhgqm97NBtan
         Tk9tHGaKWQuOBVsh/Ss/EUwIdp4T0YeSRHtmw7jOQ4Bn94bNbBtDS6EG1LWIquyXeG+f
         zvYw==
X-Forwarded-Encrypted: i=1; AFNElJ/KHXQG4KABc5nt7aLYwL7YDubIZ1ssk5EunFXKbO25f/1HzvNpUSMv41wbQK0OjXhW+lM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs6G4ja9Ttm6CARO7S0ZO2xcKys3MQtm3T5f6d6v6Atu9C4rUC
	XAs3qsqdLHi4Kgiv3ia24S7cqNosJNjiQFl9y5uqWEN5aYV1pHURvZtSUR+jiYCffEJPQKALpRO
	Npdl09tZhvwh+FyH2Jro1wef9N18KXHjRmIW7IOHBc585opxNu6/eWQ==
X-Gm-Gg: Acq92OHNm5IlCd3Xk34oX13pQnQbxEhhD6PoRYjuQsS38icultZvPgUd/VktYbI4R61
	PRGePYok3Tw4/+wTj1mq06Y+LXZM/E5fE8ITvY+rI9i2gRC/CoxrUsPV+rDd5BXuZNiSzZd7Z4H
	8TBkvnau99CxyTq5JdPCeC2kedihQemUSYVUA6ImCM94haNYHQwELt8DoZVTi0uTt3gkfB76BsV
	Bw7qugBKD6YCSBj2dxR2y67mXxDShG5Fo6z0w/JyUmctEJUwWwvbQGrCoSzPP0C56O6fHBWlMQJ
	r52RwSDjZVLdjiQLhu3px1u+rsYBqlTQfcFoRgpIYYw29O/aEwTPrpPH5i2MaFo4uBz1IwpzGid
	8dpbrmfyvY5jQjH9UZvuwCZPDLkR83JWuyl4L22TAn+uNRgtdTMr73YU=
X-Received: by 2002:a05:600c:34cd:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-48fe61f2c03mr335533445e9.21.1779199456381;
        Tue, 19 May 2026 07:04:16 -0700 (PDT)
X-Received: by 2002:a05:600c:34cd:b0:488:936a:6220 with SMTP id 5b1f17b1804b1-48fe61f2c03mr335532795e9.21.1779199455912;
        Tue, 19 May 2026 07:04:15 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57943b2sm337222105e9.8.2026.05.19.07.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 07:04:15 -0700 (PDT)
Message-ID: <eada2df3-7e3f-46a5-b290-fe0e8975a1bb@redhat.com>
Date: Tue, 19 May 2026 16:04:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/7] atm: convert to getsockopt_iter
To: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, David Heidelberg
 <david+nfc@ixit.cz>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-s390@vger.kernel.org,
 linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev,
 kernel-team@meta.com
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-3-0d8eed952627@debian.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260515-getsock_four-v2-3-0d8eed952627@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/26 10:32 AM, Breno Leitao wrote:
> @@ -797,13 +798,13 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
>  }
>  
>  int vcc_getsockopt(struct socket *sock, int level, int optname,
> -		   char __user *optval, int __user *optlen)
> +		   sockopt_t *opt)
>  {
>  	struct atm_vcc *vcc;
> +	int val;

I *think* you should use 'unsigned long' here to avoid user-visible
changes due to put_user() replacement.

/P

