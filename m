Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37203AA1A1
	for <bpf@vger.kernel.org>; Fri,  8 May 2026 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281449; cv=none; b=av6o1QHNcuB5u4O4xt5MmeYKyNCJVkh9FiQTXsYSSZcWtdCpuQIZzpZUxwmdsQGrle2rsacnAsrz+VHxMZkpRbcIkSSHpnyeYi4EMGW9hmlKaXkZC72vlOAfUOGQvNfRDDt+bCGaPdUM3Ej89eHWMEccbpHg5jhJBdsyc1vNTUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281449; c=relaxed/simple;
	bh=q61aqXrgAcupB+Zifhih+seu6DMFA/Fw8pWwohOp1Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIthGVXckvmgHnLN7+ykuO/LgZCXCIp4fUvX+tMf+6cmNJ9wKMa+rnoOgqDXQRO87J8xBhv3JKJn/U8BWaIhDSHJYAOVhw30RJd/jVZaUGLTiBYxaWV5iYZ6llsPgwdFUFmRRi9gyBzY8ua49JR0nNOKJdUjjF2ulM7tBgmePZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfY2uaG0; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfY2uaG0"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b45dff1eebso23948936d6.2
        for <bpf@vger.kernel.org>; Fri, 08 May 2026 16:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778281447; x=1778886247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ak6woxAtttxf/K0Pu5NsuJRxK4tCh/8r19p69HTWvdM=;
        b=RfY2uaG0gQyw4iSckGI91hCQl9X0yEcfj9yWuSka/KOOudIM/2dB88FfMvNd3uLoTD
         wajPs9uycinmW/jWBX0uq1nnetqD3/xU3SiZstjUHeLlLHsZGlWB+TbxAtGNhow2HUlx
         qlNCI7yx9ExUPXoXmnw7h3F8xjzx0gcLusJBzpvPtxgqNvdEGSG4T6Illa2m7XoBDFzb
         UvyYUu2vSRVeqglPGZJvQIVtlEgar66UkmVOVz0PiAbmHGDk7tJJ1I+9RQxEUVMOjrkN
         Rmg1CZhOKS+wm99c/qqi4pIvqF3cWQwVenA9kFab2ldKCSDcRrC53V/WJxsqWgUIvwzA
         2eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281447; x=1778886247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak6woxAtttxf/K0Pu5NsuJRxK4tCh/8r19p69HTWvdM=;
        b=OT/0tcStHcsosrclDIkFouvr/ToLhBzWFwonMP35n/R8sJoYHJ4pc3MlYIQWSoZE1e
         MoGv1iYIwbeEPvKRJqBviUkap6u8zVmUAE+0vUaYgBWqUCp/dUZVEgZ6yKouQmXA/F1w
         8M5sN+3iHBf+7F1xU7pSX/swzm+jEJGVYKG5plpdxuaHgyk/PmIytFMnNhBP8v9KBZLu
         LmcLkekEKyATsimJ+lkTWYvhaly74M+FcOA4ZbihDPYTsHiRdQEOBT22UQkDoCmJkCmk
         HQoAdK/9XYwt4QnLFwbGzxL3vaXdxEUJSMVfFCjwwFiClrj7ltJolzNSxic7pjgCL2aW
         vOZg==
X-Forwarded-Encrypted: i=1; AFNElJ+EfQdIzR9XZxpL2O7W5LLAf9EaGlwQUXQpzKreDZjC3kaXuretK9S9YJexspX46mQSqVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUYlH4h12WrblZ4iBlaekad1TTf+1W2wrOm3RS1rurHz2VXhvN
	DeRYMfuWOvBwQ0pDeTRqlCEAfh6EeCBH1wpzUHu/Ao5Gz761HbMSCiG5
X-Gm-Gg: Acq92OFN8rtoIHp8fzbifpAZg23GLTnO1TjjvG8YcpKMI5t4hd60hD4dcSDLYOkOVIy
	qISDsTjS4lQPzo/7TgBsdup5RCuYLu43356QGX66jXRx3WWzTJCGt2iW9k8YZXMytOTxfy9azU9
	T46ZwHEVgTGutZSXPASK8w4Y4loZj8PYILvaIex1RZzUQvIc5ltkXqHAVfm+VosuMbiZcvpMQLw
	wDae+XMEV0HWy7I2wdAJKEO2tVUn12GZ/X7zKelEOpfVvUfACfR6T81SVUCOzCkhkqY+glH6d/U
	Ftq7g3KjGy7lLtiN3CGIiLuAUX3YxXq9Bsc6n2U4vb6kctI7ycfdqr92DJM1gUVB2Yy+MLo+Hqz
	DD7EKWuaVX8kktnU1bzw+UlhtBLYtEdUxppg/ouR+9z15Q3841C8EefGfZJgHxxdBmHau1or38G
	GG+bV6ePL6lrW5tAg38tazwEsm+b79am1VzbZv2jK5YIcivg==
X-Received: by 2002:a05:6214:3d0f:b0:8a4:8b2c:428f with SMTP id 6a1803df08f44-8bc41cc2d2dmr219254366d6.2.1778281446534;
        Fri, 08 May 2026 16:04:06 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:2::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d35787esm247534496d6.44.2026.05.08.16.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 16:04:06 -0700 (PDT)
Date: Fri, 8 May 2026 16:03:59 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, sdf.kernel@gmail.com,
	mohsin.bashr@gmail.com, willemb@google.com, jiang.kun2@zte.com.cn,
	xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <af5r393EdNgGNh4o@devvm29614.prn0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
 <20260508134717.4ef87ab6@kernel.org>
 <af5Vlwb5RctHym8D@devvm29614.prn0.facebook.com>
 <20260508152708.011a9687@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508152708.011a9687@kernel.org>

On Fri, May 08, 2026 at 03:27:08PM -0700, Jakub Kicinski wrote:
> On Fri, 8 May 2026 14:28:55 -0700 Bobby Eshleman wrote:
> > My guess is this would probably be the simplest way?
> 
> IDK. Notifiers are so inelegant. Don't we have the same problem with
> the main ->dev on Tx binding?

Yes, true. For some reason, I thought I recalled the dma buf attachment
causing some chain of reference holding that kept the device alive, but
that is actually not true...
