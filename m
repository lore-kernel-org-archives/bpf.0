Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8C82D060D;
	Wed, 25 Feb 2026 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772062351; cv=none; b=G/n2FAZy1skLqglkA1zNfyJOJOUlUIP++NKz5sDS7IGvjNLORioIDXy6VyoKwgTRXmxRrrc/LoNMpViOlzWBSF7NvlhqVFPYWaxDLwco7kJTILH/OJ4yIgTy4uISttK8mNakWbaWH9z5xxf6noVzdcVcLdQYndPJhyOzLv2Zqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772062351; c=relaxed/simple;
	bh=d2Sq4NGBzPmb+S2rooLZgZkGXPENGLYy3HfkyKexBcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPRYLkqyNyzbGiIHMB4qjcBXUn/6djxKCCckKLXV7tP/0p60tpmymW/FeYf0OHdTOnF0mcjznwJxmh0vdbHltJleyY2XE5fTCiQGHIOaRpTcHBCKrZ+8JyZZq9HEQb6fWDXDhon67tn1Ld8Pz2tuN+rc/B7heqFR4fHZMurLxCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 1F88A13A373;
	Wed, 25 Feb 2026 23:32:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 574CE2002C;
	Wed, 25 Feb 2026 23:32:21 +0000 (UTC)
Date: Wed, 25 Feb 2026 18:32:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, jolsa@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-open-source@crowdstrike.com
Subject: Re: [External] Re: [RFC PATCH bpf-next 2/3] ftrace: Use kallsyms
 binary search for single-symbol lookup
Message-ID: <20260225183220.7ba404cf@fedora>
In-Reply-To: <CAOu3gNjdE_GaEEC__L=4v44iMJZt_eBN2Se_FotCDjX0BXwi1w@mail.gmail.com>
References: <20260223215113.924599-1-andrey.grodzovsky@crowdstrike.com>
	<20260223215113.924599-3-andrey.grodzovsky@crowdstrike.com>
	<20260225064723.53bcce3e@fedora>
	<CAOu3gNjdE_GaEEC__L=4v44iMJZt_eBN2Se_FotCDjX0BXwi1w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pqgebqdnkxrxhr11ecpueq3eufk8gtk9
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 574CE2002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/GuDwwTxAyw3opEMAY0KZt8caCFOlqlsA=
X-HE-Tag: 1772062341-861289
X-HE-Meta: U2FsdGVkX199A237is6672N2X1WZNI0KoNmbBe9vc8OdX+syiOBMWxU2E85u0pjXNc0eUqnqmAYRlenVn7ky3O3JLr1X4IlEaSuxmEjszPgwCSftAb9W26UlJra3VaJ0z7aC2Lm4rLy+dfwMgRUqFzVQcyQMEqpDgi3W0SdYwvQ/boc0GEspiEHmfi6roxjcV4teYMGZ7dVMjzc8REmdA1fNyBR0jX+YMerXiNvSKnjgK//cbl20ieanB1SCOkn7mjbS6DH8DNCPxi2C/odRZAH/sphrX1dERhlXzWjw7TPiLrqi5MXuajeznd5R970MGm4eMumyzxP6QwFLtsI80YWSiq82DEhT

On Wed, 25 Feb 2026 10:25:04 -0500
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

> Hey Steve, are there any extra steps required on my side to make this go
> through your tree?

I see you Cc'd linux-trace-kernel which places it into the tracing
patchwork. If there's no dependency on any other patch, I can add it to
my 7.1 queue. That is, after I get some more time to review it a little
deeper.

-- Steve
