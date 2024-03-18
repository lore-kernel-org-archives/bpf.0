Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4BF54BEF
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781476; cv=none; b=nRqpO1+CkmjQwMeVoci27bZgGxgnnLkSbI7aZouo3wXtOraLhdvf/Kp4hfQlrrsHVnPzgN1JOoY9LazEcI55e2IobXFJHdaosC8S2S7L8u+t6tTeceoIixHDyqg76NKOvakPA0tPKBy9buXZdWqTrsZ+qbhfNAex2ljg2SdqwjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781476; c=relaxed/simple;
	bh=URmegHIqiECigs/ty7nYJ+Ycv5gSZZFeO/UPXP7HJFg=;
	h=To:Date:Message-ID:MIME-Version:Subject:Content-Type:From; b=BB/L5nfUqgBKLz+ws3tqKPDdYI6T7KTn6ZprqUSJYlWHQ3yEPkUvj3o83Qm+CTBVgU7zPkqvUdXAM5YH9Vu1JX0sfJzYtEmfLpVJ8yeMVgcG47PAXBKVh/258OqyHhj3rMEihRYvP5ndTGWtIFmCv5LCA+rL7863ZFdN7e+NkiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=WI0mB0Id; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=l59PnUyV reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FPzh1XJV reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="WI0mB0Id";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="l59PnUyV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FPzh1XJV"
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0CA71C1CAF53
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1710781465; bh=URmegHIqiECigs/ty7nYJ+Ycv5gSZZFeO/UPXP7HJFg=;
	h=To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=WI0mB0Id6a51IMzjnrrkbd2Q1nwOhFL+AtF0+Keuyo//pSCMJWbZ92syAcVP03uDQ
	 99c7P2aAFvMLynyyH99QE4EEi0FLXn+n9s39Y7A6J4YMPV51q38/oeYv1tPYijwwb2
	 UVQka+bFWe9tF1pX6ulch0g7eZxAfeyR94Q4AwUc=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id EE33BC18DBA0;
 Mon, 18 Mar 2024 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1710781464; bh=URmegHIqiECigs/ty7nYJ+Ycv5gSZZFeO/UPXP7HJFg=;
 h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=l59PnUyVRMN9GJpcyQ65NEwbzjnkJ/eZglK/pYIVESNgSHy++iFuj7+p7KINb0+Jg
 NAu6tUKaHct3IbvfWtKnGYTZkOSe1jmsCc9zurIdSCctgVW8gTLnaeFSSL9fuaEh0N
 cVliju01W525ybC0E4lXWD22waKe4HlDZnx0Fc98=
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id E9A92C14F609
 for <bpf@ietfa.amsl.com>; Mon, 18 Mar 2024 10:04:23 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.856
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SBWbTutgLsJk for <bpf@ietfa.amsl.com>;
 Mon, 18 Mar 2024 10:04:20 -0700 (PDT)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 297E6C18DBA0
 for <bpf@ietf.org>; Mon, 18 Mar 2024 10:04:20 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1def2a1aafaso18753785ad.3
 for <bpf@ietf.org>; Mon, 18 Mar 2024 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1710781459; x=1711386259; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LrM3zRjiUPOIl9FUgpxwfnBfX+ju32Grg8pPTlJ3V1k=;
 b=FPzh1XJVlt0zhHt4pOVLlYCkT1LwbqSP8qTlO0DHA8X9uaPAPBR/ihcC+CHJhJHHae
 NIxM68AU/m33e9HLzPSnenNFqpeLPzSkr0LlrtdMyiJgYKLxCwzw/rzdSgbHb6ZyIg+N
 zn4LFV+nemoR4QqoG+SdQxwIjD+6EhZ5rs6r6JqLjHLD2tXTHdcRRfvqVe1eW2hIsv5h
 b/8UI2LMgSSuVcCBFsTqENOa4TRVMmQThOYjx2zJvA63FjLt9hEG5ZfebcGVk/YsMB7X
 QS4BfKFc48y5Iwh+vx8v3SI5hcFesEhkvImeOqANtlNST7cTRDqaoXmgliLH81ONrFqM
 BT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710781459; x=1711386259;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LrM3zRjiUPOIl9FUgpxwfnBfX+ju32Grg8pPTlJ3V1k=;
 b=PgC/YuIVJ4Ne8Ma7q9voSjMTDkI+juVMe8n/cW94fwmz6Uh7noPgxG/qzuS6UxZOwy
 BaKk+HzPd+wpKXU83BNFqPD2A4lDOyWjgnNdB5Nwhjeil5wwkZR8V2CY3E2UYMyN2kHx
 sp3PG2HIvP9kkuQvRjRgMZBx8PLcAyMraIuTIlh3isuC1Ormfhx09HuiRUZKO7ep54WH
 WXWfHNr7WvDNBksuF3UHhxYDQQCxI6jQhFnSFr7MvhB+SQspCbfPeqan0FBPmrsA6bW6
 Ad9sjQf3f2FXEPxBP8PBB5zPBVf9XGkWw5BJarV5mEYaSAKQvGZ0eZQmnsFUqBlMIXWY
 imGQ==
X-Gm-Message-State: AOJu0YwdfQudAcqYxNfvXBQLM2TYaHQUoS9RB5kPzD24HonhxPSNuBfw
 jz/+qB0+wf/+8r3Q4Y2EDr8wxA4KwOA06rxnvZ+8HAbCRgY03bRlOMdm676GFzI=
X-Google-Smtp-Source: AGHT+IERYA2e8cxn/sdcRgD8RacyR6226Mt/AXRC//iAAiOpFDkWzV/PgNBiViS4o5lLi7JQSI9x9g==
X-Received: by 2002:a17:903:264e:b0:1dd:e13d:6834 with SMTP id
 je14-20020a170903264e00b001dde13d6834mr9347172plb.41.1710781459129; 
 Mon, 18 Mar 2024 10:04:19 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 l9-20020a170903120900b001dd4fabf695sm9507005plh.38.2024.03.18.10.04.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Mar 2024 10:04:18 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>,
	<bpf@vger.kernel.org>
Date: Mon, 18 Mar 2024 10:04:15 -0700
Message-ID: <0abe01da7956$4f526840$edf738c0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adp5ViPBDp9Ecir+Tt2UygEkUQtvhQ==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/iEer0tiB7V66vrm3mC_3z84ewmw>
Subject: [Bpf] ISA: "code pointer"/"address" clarity
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org
Message-ID: <20240318170415.zYnBLQ7OM6cNu394lAbx6PJF1ef_rLoOMRLYila0Wxc@z>

I have a slide about the following question at the end of the ISA
presentation
at IETF later today, so putting it on the list in case there are any
comments before
the meeting.

The jump instruction section defines CALL with src_reg = 0 as
"call helper function by address", with
> Historically, each helper function was identified by an address encoded in
the
> imm field. The available helper functions may differ for each program
type,
> but address values are unique across all program types.

First, this text is slightly confusing since imm is only 32-bits whereas the
document
never states the size of a memory pointers in the BPF VM.  One
interpretation is
that ALL pointers are 32-bits, and another interpretation is that the
pointer size
is up to the runtime, but one can only use the CALL instruction with larger
pointers
if the upper bits are zero so that all non-zero bits fit in imm.  It would
be helpful to
clarify either way.

The 64-bit immediate instructions section then says:

> src_reg	pseudocode		imm type	dst type
> 0x4		dst = code_addr(imm)	integer		code pointer

The use of "code pointer" rather than "code address" in the table above
to some readers may beg the question of whether a "code pointer" and an
"address" as used with the CALL instruction are the same or different.

It then goes on to say:
> code_addr(imm) gets the address of the instruction at a specified relative
offset
> in number of (64-bit) instructions

Which uses "address of the instruction", and that sounds synonymous with
"code pointer" so the reader wonders why the same term isn't used.

Is there a better way to clarify in the text what the intent is, either by
using the
same term in the table ("code address"?) or by distinguishing the
definitions
if they are different concepts?

I know in Linux the "address" of a helper function is internally implemented
as an index, but that could just be an implementation detail not worth
mentioning in the standard.

Although detailed discussion may be in a different document (e.g., the
"[PS] cross-platform helper functions" document mentioned in the charter,
or an ABI document) I'm wondering if there's some trivial wording
Improvement that should be made in the ISA draft.

Dave

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf
