Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793225542;
	b=nv0joYu46hNP/X9kosyUAbzhzeZ4dFbndRYGUw4WxQ9Zd8Tlw7jQz4Wbk1uOAps5xvIX
	 Un/BYQKZLZ9LRmGDG+EoFh8//iOMDnKGJN1AEdSRWc0Ai4KKafSWY8b1isFo9aqDVJMN5
	 RBMt+b2MoPPVHVhxQBL7EbcdKvH4u8ulnKveYmVaa4Qgqptv+/3VAoJFSDn/ycJpAxcHR
	 exLRHX+GzT8i7mSHiycqpwcU2VgmMWAiMUsijSQ0mLLNsEvrcIklAiHaajbUuZnPeW9Va
	 IBziRAIUHMG9g9eZKA5W98kXa4sW6R+/ls+6keoMdYnulGBQeqXrMcOnGrgVbQJOVng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793225542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=QNVgEN77oBKnSnrKxR1ro4BNdRGvz1Bgwq5/dOCieiw=;
	b=NkZ4KhLhMgRSjKhLHEhnuBU3gh3PrYpCgSBwqR2JaWodX5L1b2iL4E/8cxMSR+6Wwqtk
	 BVQx8LVBumyQ4VpasM1oRS9HfL8ET6ERscmb7lcy41B2WYcSfufxpXim8nFXR2dP9w3Rj
	 gx8xMZt1tsVYOMT3iiZGPmAh0TJR8V0Xlnc50gOE2MA0VsAlDZOjeIbM8uYdI5nrxMljP
	 z9dORnL68x0vMWvv5gNPu307n8RneNKN9kZu7+3uu0ntEF+TC/hk+TI8oUsCHWEB/7dhi
	 3w+yOEm5lj2OaolCweT7rHZLUAMtBaimj5PdgxgVis6SsawahX+I6BOSXOdehV9aF9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xnkFbGfy;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F092606A31C
	for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 22:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F092606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xnkFbGfy
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd69954c755so1086227a12.3
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2026 15:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793225542; x=1793830342; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QNVgEN77oBKnSnrKxR1ro4BNdRGvz1Bgwq5/dOCieiw=;
        b=xnkFbGfyThTA7sluMZxmZe/tFqpjJvZy3BeuOLed26PK8rowB56QV2cjDujQzKsnK5
         GmKOvl3lLNDF9C5LpnDrWNawxrKWoxxU70rlZ6iwYl0mxsIKQ3ly3Lill8mPGcXbrb4l
         eUX5LUBQiWAkI0dfYPxeTURpchTwdtOcDD+9FlP4DQFXuXf3UosexQz/ERHwO6vwz+Ra
         EU6Zrfns5SFmZ3fK7Drf1jdJHaZQHj2LozTBeFtqcK0uWlapx6tvjETJwJOym6hYNh4y
         u2VCalQu7IZ1Kd+AH+8oGmszIZmyIhJhleepD2SpasexA8HSFfh0mhOul5qFADVgwGkW
         bkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793225542; x=1793830342;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QNVgEN77oBKnSnrKxR1ro4BNdRGvz1Bgwq5/dOCieiw=;
        b=hsBHMqrVcVmHSXq8Mov0Ttia0DP/KILzPaHPbAqT1Q5XBWtVzpwfaw77LNcLp0SCeU
         GMjaeX7VuIxw5k235C3vplXcA+FPpk5GQHpVjz+PcUeidifxdrvamXDVn3iPD2hF5Ppm
         URuMaYl87Ika7raW/6I2/hZ7Pn4bS9iwFygR/SNmPXX/vvsnehVL8KObBvKIPSgkQghZ
         CwaNDVpSossQvzl+6ck9gyT/R0yca7Iznn1WfWG4qXM2MPXtMNIE7Zh0fx3u03vhRTO7
         NlzShsKBaxFrwAgf5oR8YrxEjcdhi3mRX4lMrBCgrQj1lVe1jMPXsgh2el3FV2rdF75c
         HzPQ==
X-Forwarded-Encrypted: i=1; AKwUvByScn28bQrcybG8UvsgpThYNGuW2hAAS6rO+1TxXJjCjt2FP3MhnqFqStQOyfgpnp+MFV4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJo5KwISwxmM4hjj5NaGcTC3gd1wsLCFFQuu8X8Exn3rDSSrA6r
	eyE2WkrgjcvkdLxFyiSWgf/CrW+N6QImlPxoaEVArfeAfneEV+NlLM6U
X-Gm-Gg: AYBFou0dZVR3+2MuMExn+W6JNZWt/0Nooh1Jxur8icU3UG4i793khUHL/lJzh0u3HeM
	R47zmMgYH8CyhtDohfRHGOE046q8WzsXeHzGxop7Xne5j/GQbuqGWI0H6+Ouqr8bLDVSk6bk72z
	9y0bOEFkgLM5PuHkP9Rs7NemjJtAtjbD7S9atPUt6RWBsBH45dSGea/7xIWXH07VSXtv5iZoTx9
	BJUdBiOYrsaRlcdqxjqcYth7vEjne983l8d/5ApEaR6MXnu2riPi36Sa8ZEMCGtGrSlVZvR9XAb
	AlP0TdABvBqa6BkKhN+rhWYRfquSSohC6hcJjWNsDNkA2yrK13K8OsSWTFJdlnBQ+acPM9d1emj
	qRZCfN9d9ADR6oklQDTWfXuhb1pWQ6dJU/rHf8pHuWZ1hgyeFYsSYGgEop36GulEAz9wyZcj2n0
	1eWHDaX/TaaWB0v4GL+gEINrD7HYfA4qKFXhKQ7he/S9YiexIxZM6S9T+dsRZQPcpqDRNnhbX/1
	ydPhM50ezjjZkSntEnBeYgqeYsP5g82/RoViWPRqGclgFfwchp+d8sYSbcfdY0ePKqZ6jAOGVuy
	0FmqGIzR/wALISqvLDBCypAIn1WhDLP6k0GSwpzxotHM67OLhVVW7JceO082OnF9maCUiWHR7H+
	/cISAr3MHYl4BnTS00NevjM64honD7WYE7kw=
X-Received: by 2002:a05:6a21:4c0f:b0:3e2:ac98:68ab with SMTP id adf61e73a8af0-3e90246ec1amr2827999637.54.1793225541650;
        Wed, 28 Oct 2026 15:12:21 -0700 (PDT)
Received: from localhost ([153.61.198.242])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc8f97esm4400709a12.19.2026.10.28.15.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 15:12:21 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 22:12:20 +0000
Message-Id: <DMGTEGTLTEUX.HECMYVCWNFQA@gmail.com>
Cc: "Eric Dumazet" <edumazet@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Willem de Bruijn" <willemb@google.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH net] tcp: restrict SO_ATTACH_BPF to privileged users
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Manjunath Patil" <manjunath.b.patil@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
In-Reply-To: <CY8PR10MB66609715D3216D1B10CC186ACF6F2@CY8PR10MB6660.namprd10.prod.outlook.com>
References: <CY8PR10MB66609715D3216D1B10CC186ACF6F2@CY8PR10MB6660.namprd10.prod.outlook.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Oct 28, 2026 at 02:58 PM Manjunath Patil <manjunath.b.patil@oracle.com> wrote:
> Commit 5d39580f68e6 ("tcp: restrict SO_ATTACH_FILTER to priv users")
> requires CAP_NET_ADMIN to attach a classic BPF filter to a TCP socket.
> However, a caller can still attach an eBPF socket filter through
> SO_ATTACH_BPF without this capability. Both options install a filter
> that runs on incoming TCP packets.

Nack.
SO_ATTACH_FILTER takes insns that the caller wrote.
SO_ATTACH_BPF takes a prog FD, and BPF_PROG_LOAD is the gate for it.
unprivileged_bpf_disabled is 2 by default, so the load needs CAP_BPF.
An admin who sets it to 0 allows every user to load socket filters.

> Disabling unprivileged BPF loading does not close this gap: a caller
> that already holds a socket-filter program file descriptor can still
> use SO_ATTACH_BPF.

That's not a gap. The FD is the permission.
A process with CAP_BPF loads the prog and passes the FD to a process
without caps. See the comment in bpf_prog_load() and
commit c8644cd0efe7 ("bpf: refine kernel.unprivileged_bpf_disabled behaviour").
This patch breaks it. It also breaks a process that has CAP_BPF and
doesn't have CAP_NET_ADMIN.

pw-bot: cr
