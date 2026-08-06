Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877C6425898
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052631; cv=none; b=flbFjor486GftdjjQp7HfIh0uwd4oCH0h/IZAGAYGJh73bXWiWIql0P0k03kI6LKTMqn08RvlHM5C4uTa7G9limE1/yUHXP/B8zaOpXiyjd/vTpmM9UwgmY7JR7pcep21T60D9GdZ2kdxHV+X8hn0QUUiUh3u5vN58ixzZws2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052631; c=relaxed/simple;
	bh=35TYsFLQXxz5lphjjry8NJodbiArqT6uWaY3mX94OXE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pYz93uM/T4pbfhDhdeMNAh0ocBr7CbN5WLP4oKY19AqSLt77eZal+xHfoU+Tq31L9oFyYQMVyj9B8UvYToJUn8AlwEEZlTna3Jm+Wo7gtTcuSyAlWK6UBDGBO6nxJ6VOa61Jh8Jt+uCX1ioFnAY0iiLkXK9V8HH6V/pqOT0zvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L/W02PQB; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L/W02PQB"
Message-ID: <020840ba-952d-466b-8307-67d3d86cc104@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786052624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=35TYsFLQXxz5lphjjry8NJodbiArqT6uWaY3mX94OXE=;
	b=L/W02PQBqLXAaPLuzE7F76ZqBErHJ0v3zeNpV5vaVFaJTW1PBeHtYuZkjcDhnUGYAd4wEc
	OQkqkZhydwaaz+KMVBdQuCM7S7uY/SRyI+pUGM2JjMbWp40O11dlLHi+HfW7IavcF6tRA1
	6xHJ4GAvFvTZXhOqKZqXjNf3kP2X19A=
Date: Thu, 6 Aug 2026 14:43:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: bpf <bpf@vger.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
Subject: BPF CI is not running due to github outage
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi everyone,

GitHub is having a bad day:
https://www.githubstatus.com/incidents/qcvjkzcs7j74

This means that BPF CI, including the AI reviews from bpf-ci bot
are not running until that is resolved.

Thanks.
