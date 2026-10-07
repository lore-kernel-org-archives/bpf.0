Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1A93D25CC
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403188; cv=none; b=XEe9/5YwryupBhkczN6KPyvZYszWiiKmpGhPCRzaKE71SoegCK3iE68kESGbF7OdpE6Z95+G/iGVX1h2Qy/pzLyJ3a5q9ZSHns89ysf+8FRzsdH2B4COv/o6wfGtlyzK5+5JIfe2ypqxsa40GDtv0Edt1SPd8lTZwY3QxMu/3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403188; c=relaxed/simple;
	bh=9a4Dm60vxtzlMbXWA8VDF1XlH2veWvjBLLJqbddC/c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1s1M8kpKRpnjZavtkd8lT/EIrOVqVYmms9ziUjaYKCY7IpUqikhYPtc1UCzRMiyu0o+VAQBU1htgx4Pbh3F+kxD2cKqdu/Xh8mJhvwLY6K77E2tCBuD+9cnYC3EDV3Dq3JUFVfICtfznJaEcEtdRTq70Jb/Dzj16bHdJwzCMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=VQJCWDIi; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="VQJCWDIi"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6d7e06dbcccso1564760eaf.3
        for <bpf@vger.kernel.org>; Wed, 07 Oct 2026 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1791403184; x=1792007984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ORNIi3goQ2NILjOPLuvwnDpMQPxIS+GPNDMPNL6cdzg=;
        b=VQJCWDIiCMpmykN5cfBT1dGOTvqgc5vRuYjepDPIGfbdlEcKfLm5oCb7qlcHW1zU2n
         DezVlt9uZwB4xmLLr9h2C0E5E1r9uEUYvQAsn3NCTVSOT9+d3InZCEwh+1E5xmg8xTzf
         cscX5MZwhUqG3Yv5yy8j7+BBFG9FLxjQD4yGuPx/WWJrOKN6fSNmlWsh3bQK+8MtOJ3l
         /yfQAYppYW3gh8VjJR1bLwH5irLq3gm+wOG7sPGEDOR5Osdzn9/a2z7FT7J3vi10vr8P
         VkULc+k9w08S7lKg/uk4PHvEdH0+fhK7lUa/m6A1mX8TLzT5jDLOKXg0fEd4W4PAuwt/
         pOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791403184; x=1792007984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ORNIi3goQ2NILjOPLuvwnDpMQPxIS+GPNDMPNL6cdzg=;
        b=toGDpuOCOAI2PIwlXdkdXvh0QQL13w8VS0URyT1JXMxA3b3HLy6jbA4MUQEb59OqLW
         eM3ZhUUZ7xKY0KGBEaa5xF84oDS6x6pmEgjwuWwgop8bX8RCHBqur+0vb6j3dQWcPvog
         CP6nkggXt9GuqQX8u6noidmzBNfcbT7hcoM+nLVIJjhb1GC731B8HYxXnueFLt/8Ola0
         lLnnMdhmebQWYw+6eaNZwaEEZIDsd+jT/XDdNv33vxiYbuShYXNPw58rGynIGCui2B0n
         P/W5OIhojiWs87YiMLpmXq5NoDh7HaWHNgzutDAcMncjm6Uttry75qghRFeZsXek+P9q
         PuQA==
X-Forwarded-Encrypted: i=1; AKwUvBzpCzNxS1J8jKYEgaqYdWon3eIdOPYWOMH6pSmOF6lZezBipIrtabh4+aMyGOC4QxLP2yg=@vger.kernel.org
X-Gm-Message-State: AFuF++m245yxgky1i5Qd2jxq6PGmE0U8R1ykT/ovn5+H8BeXOMoggko3
	0Eclsfy6VcNoA5obgH5UpOt8ymkkZxnkVPy55xai/OiPHiXd/XdE11A+c059kICCgCQ=
X-Gm-Gg: AYBFou2y4ymAOihyEvsgx5q8Xohg5K6RC7/+3p3KCn1mRN9yulbDFqwSBO02lMMnEAh
	ZTz8REghaB3y3Cn7w+yG+t/uWJ4CAFHUDtqXkoBXORknSIVyjMfVSJ4aMuvXZX+rjut1cd2kGEn
	l1Gc50cNvUKy8JavJidTtMoS1IEXPUGT/8HQMGgpL8Ma8OdRmX/H3h5OtuI/dQo6C7ByCj4YITM
	I1LU6r/QCoxytgimN8wCGRcKlYNrWlRb/Al077oaSlvyjOHaY7voURfCSMdXqFvg3S1s0nuCBus
	nX2wwB8tX09I/bWjw1SmD/NSvW/OnOkl5BZTqPnIdS79jTPIqS5QL5XwrYI010ljyrA5SnADzvH
	M+FsUh5So76iGXz7WhQwWinxH3eJUavYk09zaL63ZWvAE6Bq49xc0M5mMYgoILnWcslTK+pQ73W
	mox+aGtPx5EQs81eUpx30hBPAADgUJAMToVOesLN8w6YkvVqnjrBsPZ6UvElWY6t+7OGafiA+zN
	g6BB9sAsdfjzL0cuwT8ZtQs0iKWQ/0MNuJ4XAwlZw==
X-Received: by 2002:a05:6820:1a0c:b0:6c9:80d8:a1ea with SMTP id 006d021491bc7-6e7a8050b6cmr3013643eaf.39.1791403184292;
        Wed, 07 Oct 2026 12:59:44 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a274c9c520sm1084285fac.16.2026.10.07.12.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:59:43 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>
Cc: linux-nfs@vger.kernel.org,
	Daire Byrne <daire@dneg.com>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH RFC v2 4/9] SUNRPC: report the transport's class in the svc_xprt_dequeue tracepoint
Date: Wed,  7 Oct 2026 15:59:29 -0400
Message-ID: <27416e906f563f9b5c9c9231d4a0406193d04890.1791402701.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1791402701.git.bcodding@hammerspace.com>
References: <cover.1791402701.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Coddington <bcodding@hammerspace.com>

With dispatch round-robin across clients, which client a transport
was served as matters as much as its address.  Print the class the
transport was bound to at accept: 0 for the anonymous client, the
class number otherwise, with "+addr" when the client is one address
within the class.  The peer address is already in the event.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 include/trace/events/sunrpc.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 77efe63d2c14..107fbed5d556 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2042,20 +2042,27 @@ TRACE_EVENT(svc_xprt_dequeue,
 
 	TP_STRUCT__entry(
 		SVC_XPRT_ENDPOINT_FIELDS(rqst->rq_xprt)
+		__field(u32, class)
+		__field(bool, per_addr)
 		__field(unsigned long, wakeup)
 		__field(unsigned long, qtime)
 	),
 
 	TP_fast_assign(
 		ktime_t ktime = ktime_get();
+		u32 class = rqst->rq_xprt->xpt_client->cl_class;
 
 		SVC_XPRT_ENDPOINT_ASSIGNMENTS(rqst->rq_xprt);
+		__entry->class = class & ~SVC_CLASS_PER_ADDR;
+		__entry->per_addr = class & SVC_CLASS_PER_ADDR;
 		__entry->wakeup = ktime_to_us(ktime_sub(ktime, rqst->rq_qtime));
 		__entry->qtime = ktime_to_us(ktime_sub(ktime, rqst->rq_xprt->xpt_qtime));
 	),
 
-	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " wakeup-us=%lu qtime-us=%lu",
-		SVC_XPRT_ENDPOINT_VARARGS, __entry->wakeup, __entry->qtime)
+	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " class=%u%s wakeup-us=%lu qtime-us=%lu",
+		  SVC_XPRT_ENDPOINT_VARARGS,
+		  __entry->class, __entry->per_addr ? "+addr" : "",
+		  __entry->wakeup, __entry->qtime)
 );
 
 DECLARE_EVENT_CLASS(svc_xprt_event,
-- 
2.53.0

