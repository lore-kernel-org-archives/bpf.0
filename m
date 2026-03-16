Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650DE13B5B3
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 22:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699284; cv=none; b=KWQAepn3i9TTlyxMwA8NvaQBGl+NNRk5Q789/xKozD1Rm+F0UUpOePOsPXLjVJ4KkrSB5I456FW/3y3iF6eeHlOEvqq+Tv09qBEUHOz/xMMD9VLuBstOiljFRFL3bSJTseN7bDFTQmLM7R5gJbLIFRMuflX1iAtwLJOZcoTqGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699284; c=relaxed/simple;
	bh=HGj5yiUG7iKWATjOzUz8OSk7F9PspHcBFX+MhNveJts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaUOodzq5YLBCy12vxsrcBva0/WSlyOeTBMSdbRVf9XKFT7ZpAaQnOuoWZPu3CrNP9uXgrIAME+BStZjwKMLRELYCZQHkiu+P4YIUhZMQ4yXyQYkZhhW8vYGwcLV6BWErTo/75MzZOZ8ZDhJ7hZDvLswImW6kBrFR1xtyZHO+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTH+pELL; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTH+pELL"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89c4b4ece7bso2159616d6.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773699282; x=1774304082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xVo0DvHLvdFL5zFcyTS5pi/B+LyIVJQdufAwf30Klo=;
        b=gTH+pELLcKYJsiNcJvWi2+XVvonHdHeESyISqkJ/8XBdU31sJZU54Dafsf+tOfcO7S
         LZzyi6Q27OscB9DBKM9PSCFNq3bIKRKI8AzHzvgxAHOFdvk69VUkYpszBl0bMrG4o+qm
         CwmF7fOYP9iFPaXJtuSJY6C3P99CZv0dmNHpssHaizJu4v8p7xTVxvu8E+VKDP9XyYbh
         bsCGmdfxFVAydBEnEm8d5FNfbjZhIDOlfDb/GdiFjs729HlD/PyygvwmB898d4lbFH77
         chh4j6zq4JEDejcZCjtpD+Tj/P4lZ76LcXgXMzYv+feMt9RPGjhgVGCYOHqugQ2mI7VP
         EKaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773699282; x=1774304082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xVo0DvHLvdFL5zFcyTS5pi/B+LyIVJQdufAwf30Klo=;
        b=a6tI8XswoyDE/OTzi2sX1fvZy8QmuLhv5tHlFk2OyYgf7NMh18MhP3NS5B5oAZ1xPR
         eXiDxWxae2PxmFkjVeBQkbmwsVb6wnm+NLobhp9j811CJ04ByfqJE+8eQFyoe9guH7wB
         DshWtu6ilb+0pN0L9dEST9biYo5o7GXElJ+mwDz4miYtdyv7YimF9J6sAd8upDspiUd9
         WObC4SSC0Qww8WekGR01rYi4JkBKUgg/NlbuDsSGqR0qVEMyHQ0JrUS8PecYZx0xpZGB
         7+caNNHDeI6bgKkMyBK7hm1N0GiEeLkRCBw560h6Dw9exO0QV8ykNPDk3fOz7yVHORU8
         5fkA==
X-Forwarded-Encrypted: i=1; AJvYcCUyjC2yLTJ9ziJc9WkWIOy2JBOZzDmpWGA3A1VPcOvXvDAndkjt3FZ3BMc4Hfy20kdr+Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YysOlBR/hKWiMsz8t4VWyoP5+aBExlR3HJjtUiY7NNwqR/GPUTL
	EXiNLKjrbsf9nPfNdMg2vMLFspuDhhHi7UlHgPXvDlbdbYCIn2jkMQzf
X-Gm-Gg: ATEYQzwOo5aRX1LEJ1shhc0yeWq/eM3anxBQbp3/b2nvy7tmo8vcQDrmw2vLBQcDFa6
	wDlcHMgD4bV0VI/u7cNUu7dcRmzBiQfxRx784thnx21Hf2Mc+XWl7NnM/yphFHP1Lz1iCO5Zr11
	jGS6rvsBk1sxqrfN0df4ng6SSNFE8nbjZQPT4lVmGr3r840HbZrYI9vK7vVlm5s/U08vIl+0Bi5
	cNJ14UJ+8S/gmSOY2efzKudY89HaP80OR/fuu4CjZOLrxuCV+JBCMUnkk2Is7Om5cHp1S7/x0Eh
	NHP/4VdzczFay0BYQCtbfJ4fPJ96T7uY/G9ooGxNDXaVdmvRMxMf2Di6E2m/dJYGUDAWLAqBeBB
	Yk5DmaQJXYQ1A+GsIJmm8tRvuTPrthFM+R175dV6AJc6/Vvrj4O6O9xIUBCPI0yCie388Cyh6qV
	nA8GCl3ct7O4xavU348/A+IsEybubXoEO3/Nepa6xzkX+LXY6e9YxAwLzOF9b4uDqFerTfK6RR3
	cNSff0+xje5VDLqycXtCNL7B5ZD491UT2q2D7bDGA==
X-Received: by 2002:a05:6214:252a:b0:89a:424:984b with SMTP id 6a1803df08f44-89c5e3c81ffmr17623666d6.31.1773699282359;
        Mon, 16 Mar 2026 15:14:42 -0700 (PDT)
Received: from kerndev.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65beeb7dsm145596556d6.19.2026.03.16.15.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:14:42 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: fred@cloudflare.com
Cc: paul@paul-moore.com,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	kpsingh@kernel.org
Subject: Re: [PATCH RFC 1/4] audit: Implement bpf_audit_log_*() wrappers
Date: Mon, 16 Mar 2026 18:14:40 -0400
Message-ID: <20260316221440.2043299-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
References: <20260311-bpf-auditd-send-message-v1-1-10a62db5c92f@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Frederick,

On Wed, Mar 11, 2026 at 04:31:17PM -0500, Frederick Lawler wrote:
> +__bpf_kfunc int bpf_audit_log_cause(struct bpf_audit_context *ac,
> +				    const char *cause__str)
> +{
> +	if (log_once(ac, BIT_ULL(LSM_AUDIT_DATA_CAUSE)))
> +		return -EINVAL;
> +
> +	audit_log_format(ac->ab, " cause=");
> +	audit_log_untrustedstring(ac->ab, cause__str);
> +	return 0;
> +}

Rather than putting everything in the cause field, could we perhaps
have a separate kfunc here that appends normal stringpairs (not
format strings) to the audit record:

  bpf_audit_log_str(ac, "result", "denied");
  bpf_audit_log_str(ac, "op", "read");
  bpf_audit_log_str(ac, "scontext", ctx_str);

I know you didn't want to wrap audit_log_format(), which makes sense,
this would be a midway point between that and stuffing everything in
one field.

> +__bpf_kfunc int bpf_audit_log_net_sock(struct bpf_audit_context *ac, int netif,
> +				       const struct socket *sock)
> +{
> +	struct lsm_network_audit net = { .sk = sock->sk, .netif = netif };
> +	struct common_audit_data ad;
> +
> +	ad.type = LSM_AUDIT_DATA_NET;
> +	ad.u.net = &net;
> +	return __audit_log_lsm_data(ac, &ad);
> +}

Should we also wrap ipv4_skb_to_auditdata() /
ipv6_skb_to_auditdata()? Smack uses it in smack_socket_sock_rcv_skb.

Thanks,
David
