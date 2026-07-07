Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E09426423
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434838; cv=none; b=Xof0a4pxdyVFjDtgakDtSI5YJwXnjX0gdoykLxHaQlGcwbKUr8of+qsurjmp53BGVd1FKmkeMyPysstEI+PcaWA5bX3l65zIR8uFnLw8/ucHWeM3K98Y0ZhWW1WWrc4inWQkZuC6oi0CbW0oELy9qKkjr7jdjVyUfXo05xRFjSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434838; c=relaxed/simple;
	bh=uoaSrEaF2U/AwdaCa2IXOKZyAE7DXgSZdd87uQF3MPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnhJas7bR79W5CQs0n04YHLl8YuzpxQm3++JiTVyztf+MwQyA6+6H+sseRWTX/d+BPNzvOTRw63hFHxlKMQakDFa0xqRQ+JpASVifZLSIk6oF3mAGFWcLGJs1fCWnKuHM5DCz6HnEHSMoMijGEXMMUsrv8Mhza6jd4qUNKTzK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CT0Xa/Uo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CT0Xa/Uo"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84830c774a0so721958b3a.1
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 07:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783434836; x=1784039636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Co78LYEqO7Xq0HUigIABDWSc76R4xuWDdkk/ckElme0=;
        b=CT0Xa/UoYyRBYEyEY4ESNz4Qd5tLFFOloCHAFK0A4tuEdB3NwvQkzb0OvbNfpUW4Ri
         v7ntgu1QS4KtLA0AYevyjeR2BXQfW+i5X0PAItFlNJR1edmCIJqfpkM9m7TvTAk3Z33G
         hCNK7z/AlZXc/SfAe92RHJIvuELTJTTPEzz0hbBgyd3P7y8m4nddb8O0BoiaBRmtEtQT
         8tvoGRGt8KIy0jU1+Bchhom8n9azidOGh7FC/q0sE+GkQqK0GGf8hdBAZgqSKRDFJkzI
         VYmbM6P4ogAeFOzkoE1ndCG35ClyTyu5305XN2y1Y5ZmdeopBN3A/nUp4KrwcaeYuIjj
         dxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783434836; x=1784039636;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Co78LYEqO7Xq0HUigIABDWSc76R4xuWDdkk/ckElme0=;
        b=eyyXCjhR275qJHxNRPTqh42K6qbMZwOwC5SlTmoqLVl1KIEwlqYXYJKK8F+pQQRmui
         TEf4wi0u4w80XdK6LGWWaw9YpPj+Ehy2kv0a64R5YBVfXKXubj5wlrO6yWa226hNxr1C
         6tjhWLlD4Tx9CAac3WOCoSHheCcDTdtyMtlQL4wpvz2kqo9cOmgarmmks1JHRh8uv5qX
         iIuIXIVpVE26FXcR4ATw35zYBxqhAXE1z4R7VY2Fw8aGrlShSPorrQQijN1sxHUawCqP
         H0ZH3a9SlG5XsDC8yWiJXnIeXznzsTxZBUIe3sG5z4DbMJMULYdB/0Fo6xlgyD4NDUV1
         jx8w==
X-Gm-Message-State: AOJu0Yx5/CiUwdiwYEwjiIAdhqwN+ZpAdTZqd8tSuAD61KhvsTFLC2Cs
	YQp5ufqHK0Z253wIqjhxhQYVcEOWSSBgbyG8opdjIcSjbSCroQxbrsTB
X-Gm-Gg: AfdE7cl88ymSdwq/q1Ss7YGTGEb8h2PPTsl0mQ+zK21nboitFApoPlfXctCI7oN5DQQ
	0OlUQpNYYsw8WWlyNSXUi3gO1hn1EWKy1ve1FoI9Qfh5V4mfGFQXRuRifFE3eRh6BA692miRliL
	szBo3ij32KEtJSGEoADR0UQ7tFJsODIEW838KR6T9fqZeOru3HW4hyAo1siE6PMUh9sVjVkXmQq
	hwhoaP9MSJzrGP7yNTVhGuIqOjzGTBfCw1PlyMsFubd+duRnfoGYubyvWumC9/v1O7NPhC3nkTr
	TUmL/UFP+K+9zpNLveK9VD6GH0oGrKQJIUMk1rc5Rn073g229xZ2+mS7rihmVdm1pWqYIaxj+aj
	6ALu07pQc8zJ6H+7ll/AkagcoQiDrj2ymQvLxLXq9MhrYLu3QnR461XWhpltIqAMekdGCyjimKo
	hFyqH/eW6Cag==
X-Received: by 2002:a05:6a00:2c87:b0:842:4f20:53ff with SMTP id d2e1a72fcca58-84826d98971mr5346111b3a.42.1783434836558;
        Tue, 07 Jul 2026 07:33:56 -0700 (PDT)
Received: from john-p8 ([98.97.43.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d7a96fsm5539485b3a.46.2026.07.07.07.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:33:55 -0700 (PDT)
Date: Tue, 7 Jul 2026 07:33:54 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Mattia Meleleo <mattia.meleleo@coralogix.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	"jakub@cloudflare.com" <jakub@cloudflare.com>, jiayuan.chen@linux.dev
Subject: Re: bpf, sockmap: FIONREAD returns 0 for TCP sockets in a sockmap
 without a verdict program
Message-ID: <ak0NXYLSMqi-HH72@john-p8>
References: <CAOvpEWN6xgFx4GWFnnWLGCB+_1auDcAZPYPSv1PDu3UfXkcriw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOvpEWN6xgFx4GWFnnWLGCB+_1auDcAZPYPSv1PDu3UfXkcriw@mail.gmail.com>

On Fri, Jul 03, 2026 at 06:10:16PM +0200, Mattia Meleleo wrote:
>Hi,
>
>in OpenTelemetry eBPF instrumentation we use a sockhash to track
>outgoing TCP sockets for trace context propagation. Sockets are added
>from a sock_ops program, and the map only has an sk_msg program
>attached on the egress side - there is no ingress verdict program.

This is how we use sockmap in many cases as well. I just haven't
rolled out any actual workload tests recently sadly. I expect we
would also hit this.

>
>Since commit 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap"),
>ioctl(FIONREAD) returns 0 for these sockets even though read() returns
>data. tcp_bpf_ioctl() answers from psock->msg_tot_len, which only
>accounts for bytes in ingress_msg. Without a verdict program, data
>never lands there: it stays in sk_receive_queue and is read through
>the tcp_bpf_recvmsg() fallback, so FIONREAD always reports 0.
>
>The commit message explains that sk_receive_queue is intentionally not
>counted because a verdict program may redirect or drop its contents.
>Without a verdict program, however, all of that data is readable, and
>applications that use FIONREAD to size their reads (nginx, Java, .NET)
>hang or truncate transfers once their sockets are in the map.
>
>Observed on mainline and on 6.12.75+, 6.6.128+, 6.18.14+.

agh because fixes tag it was backported everywhere :(

>
>Reproducer: https://github.com/mmat11/fionread-repro
>
>  pre-insert     FIONREAD=4096 (expect 4096) OK
>  in-sockhash    FIONREAD=0 (expect 4096) BROKEN
>  post-delete    FIONREAD=4096 (expect 4096) OK
>
>Is this intended for psocks without a verdict program? If not, would
>falling back to tcp_inq() (plus msg_tot_len) in that case be an
>acceptable fix? Happy to send a patch and test it.

Its a bug. It needs a fix. Please send a fix I'll review and
test on our dogfooding env as well. Would you also add a selftest
here so we can capture this behavior is fairly common for apps to
do this.
