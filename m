Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33C130C36D;
	Wed, 18 Feb 2026 18:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771438264; cv=none; b=HBWra+w1I5yU/vlfYcTx9YKtkxGM7+nWLnsMYBniVJi8xzadd4vOROjiU8fyxoCsEh5IIDWgzv22q2dolVDAcqfqaJrN+XybjK/7YGBqrgZdWwVY1QCiulTdWXVrmxq/ODtOFvceGXJfEFU0ka646k0uhnO8hfSkVXlxHq40VGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771438264; c=relaxed/simple;
	bh=rA5gMR37MDpjz9eyL5XNOXh/Nz/8tstNNH9OVKR8N6c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ncP9eeC5zSCyMRHKzovWEOQWMWxNPxZbmXq+6hJCHLLLfUQkSWeXUGJlIfqBCmXFLf8cbR1c6TJoZPRhBL8rLK1TPK6qLzsVkjdJiMhOXzqzwK9IUGtdvyEmZKu9uqNV+Rx4LHXDH156VZgsMDSZ3bTqZ/2exNbwV2ruZsEDYiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBZnvkQ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBZnvkQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C81C19422;
	Wed, 18 Feb 2026 18:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771438264;
	bh=rA5gMR37MDpjz9eyL5XNOXh/Nz/8tstNNH9OVKR8N6c=;
	h=Date:From:To:Cc:Subject:From;
	b=nBZnvkQ32ioABPbkoVrPYmVQ/mxKFPX4oWh+lgssfKp8QSvaIdx5hwf5trMcVX1kX
	 /OktoWuLiLK6jMcc2cf1beW4GHrWOLI11as35ktUA42lawW7kDQUOrQdfxwyDKFzf9
	 2kKyV9Ewa6Ii/xmnsZBWa0WGSWSjjHQPKZzTG1qZoC1F7Gr8GBxlxAnEUZikUywK1r
	 xs1lwD1bhSYwiiXR1XuR4wzakrw6fZbTiN1AwA/g0XfXd8KBoZWV1KEtq7stP67n2i
	 OqUfiTfzUSprb4mzfuZF/D0TJHxIhJ/xwNsFyXJy/oiLvnShjpcwo6orLOn9/qmKi8
	 vvRVS8IVrlAdw==
Date: Wed, 18 Feb 2026 20:11:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Question about redundant copies of json-writer.c
Message-ID: <aZYAtL4Nd3LG8wHb@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Shuah,

I'm working on a kernel patch set where I need to write JSON.

After looking around a bit, I found this C-module with multiple
redundant copies scattered around tools/:

❯ find -name json_writer.[ch]
./tools/testing/selftests/bpf/json_writer.h
./tools/testing/selftests/bpf/json_writer.c
./tools/bpf/bpftool/json_writer.h
./tools/bpf/bpftool/json_writer.c
./tools/net/ynl/ynltool/json_writer.h
./tools/net/ynl/ynltool/json_writer.c

My (arbitrary) guess is that one in bpftool is the main copy.

Ssince the module is self-contained, I'm dilating towards doing this:

$(OUTPUT)/kcontainerd: kcontainerd.c ../../../bpf/bpftool/json_writer.c \
                     ../../../bpf/bpftool/json_writer.h
       $(CC) $(CFLAGS) $< ../../../bpf/bpftool/json_writer.c -o $@

(and in kcontainerd.c #include "../../../bpf/bpftool/json_writer.h")

I'm just sanity checking this given that json_writer is utilized with
a different pattern :-)

BR, Jarkko
