Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850528;
	b=y7vWxU3vFDG1crgfPRwOf716pENcR+oL8HEMqjxU1HP4f/713UBlBlvfCy2+mHrPAfwz
	 9LgFVZ85bYynmpg1mMEyzHLzG9kjHesRUR9e0qF7hwSroP1Xnlv9suaUXSH+w0Zc5BTf+
	 npWZ1W/ECTejN+7XQFcELwvT04vVuvMd4GirzwN+HswEdlP59CuUMB3zuUup9huJgUdJR
	 68sPw6GgJYebfD7DbCQCr7sBC535pdsG72XwcmrNBvhN6rTYHVc0GGynP2fKqSxBsGcVv
	 zW60zTBO7HzirMnvacCsshkxoJyx+zytL5IZ/CDA0THreJ0AFmhqYPhhxc4Ak1x35Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850528;
	h=DMARC-Filter:DKIM-Signature:Received:Received:To:cc:From:Reply-To:
	 Subject:Date:Message-ID;
	bh=QRQSihPnl/DBjDu6sH7FJX74R4mlaIRn5Lf9t7J6634=;
	b=y069SSL/PJZ4dmlhAcYz0C50C3POKzTtun+SyeiY2leXXMPuazCrqii6gCbhA7GcHH44
	 v5aGNJ7st1eGD+Ue3Vt2qRQ0L0fEKH711QnL0/sLlCfdq3vDXxPS25VQnypxEW75rDoJi
	 DrGlxLxcjc8Ucnve2Y8uFXTqngKn3eLSF3c37JUdMD1/wx6uE6X198k1fcIGS50+zdnKY
	 SsNP4kmqAXXNULRqjVinfHyAu9ZZdgrcol2kDrHbKC7TDvV/reXmzOmc8i5NvIrLnDu+G
	 B6fxYesrK7FwMLZGqNG/4JxjyNWcarno7m4uxzTjH54vedPka4Gva+I4GaJUOSst2UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	dkim=pass header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=DtTMCczw;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057F606A32C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 17:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E057F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=DtTMCczw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:Subject:Reply-To:
	From:cc:To:Sender:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QRQSihPnl/DBjDu6sH7FJX74R4mlaIRn5Lf9t7J6634=; t=1794850527; x=1795714527; 
	b=DtTMCczwhS+DiWel1nwj1GS/dVEG+JR7dKdmbgtz+wwkVv8c8rIBQ6lwmvxVxLONO084/vs7jph
	AQ7aNX1mJGf9POJUwELqc38IHc0DbxcJU+p/vygpD6OuzGQnSBE96eRKHxyEnA7usjhfTTB+g9ct4
	AjUtkb8NVGjpq8+oqf9HoXAAKKfZChM2abyzEaT1wj32PgpmyGCGujaFW2IzU3LGRBc1t1NJ+6NPa
	OjglHf3xis5wIha8zzyePheTfTiqDeFEvhnLSMEkrptO1ttojSKnTk6z1GY4GUe/jYZLm4zHpJ04D
	QmOfRbgdZYY/6lYy5c+GJHt+mKd/Vrta/0wQ==;
Received: from 30-11-166.wireless.csail.mit.edu ([128.30.11.166])
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1xT0c0-007JAT-0q;
	Mon, 16 Nov 2026 12:35:24 -0500
Received: from 30-11-166.wireless.csail.mit.edu (localhost [127.0.0.1])
	by 30-11-166.wireless.csail.mit.edu (Postfix) with ESMTP id A493D3F6DC37;
	Mon, 16 Nov 2026 12:35:23 -0500 (EST)
To: Alexei Starovoitov <ast@kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    John Fastabend <john.fastabend@gmail.com>
cc: bpf@vger.kernel.org
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: a riscv ebpf uprobe can wedge the machine by writing pt_regs.status
Date: Mon, 16 Nov 2026 12:35:23 -0500
Message-ID: <30318.1794850523@30-11-166.wireless.csail.mit.edu>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

On riscv, kprobe_prog_is_valid_access() allows a "uprobe" ebpf program
to write ctx at offset 256, which is pt_regs.status. When returning to
user space, ret_from_exception copies whatever value the ebpf program
provided to the CPU's sstatus. One way this can cause trouble is if
the ebpf program sets sstatus.SPP to 1, indicating that the trap
should return to user space in supervisor mode rather than user mode.

An ebpf program can do this if it starts with

  7a 01 00 01 00 01 00 00 

i.e. {code = 0x7a, dst_reg = 0x1, src_reg = 0x0, off = 0x100, imm = 0x100}

Robert Morris
rtm@mit.edu

